import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Question/Reponse',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyQuizPage(title: 'Questions/Réponses'),
    );
  }
}

class MyQuizPage extends StatefulWidget {
  const MyQuizPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyQuizPage> createState() => _MyQuizPageState();
}

class _MyQuizPageState extends State<MyQuizPage> {

  List<Question> questions = [];
  int questionIndex = 0;
  bool response = false;
  bool? responseStatus;

  @override
  Widget build(BuildContext context) {
    questions=_getQuestions();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 400,
              child: Image.asset('assets/photo.png')
            ),
            Container(
              height: 150,
              width: 300,
              decoration: new BoxDecoration(
                border: Border.all(color:Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              child: Text(questions.elementAt(questionIndex).questionText,textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),


              ),
            Container(
              height: 150,
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () { setState( () { response=true; _checkAnswer(); });  }, child: Text("VRAI"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),),
                  ElevatedButton(onPressed: () { setState( () { response=false; _checkAnswer();});  }, child: Text("FAUX"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),),
                  ElevatedButton(onPressed: () { _nextQuestion(); }, child: Icon(Icons.arrow_forward), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey)))

                ],

              ),

            ),
            responseStatus == true ? Text('Correcte') : Text('Incorrecte'),

          ],
        )
      ),
    );
  }
  _checkAnswer(){
    setState(() {
      if (response == questions.elementAt(questionIndex).isCorrect) {
        responseStatus = true;
        _nextQuestion();
      } else {
        responseStatus = false;
      }
    });
  }
  _nextQuestion(){
    setState(() {
      if (questionIndex < questions.length - 1) {
        ++questionIndex;
      } else {
        questionIndex = 0;
      }
    });


  }

  }

  List<Question> _getQuestions() {
    List<Question> listQuestions = [];
    listQuestions.addAll([
      Question(
          isCorrect: true,
          questionText: "La Loire est le plus long fleuve s'écoulant entièrement sur le territoire français."),
      Question(
          isCorrect: false,
          questionText:
          "Auxerre est la préfecture de la Nièvre."),
      Question(
          isCorrect: true,
          questionText: "Agen, la préfecture du Lot-et-Garonne, se trouve sur les rives de la Garonne."),
      Question(
          isCorrect: false,
          questionText:
          "C'est dans la cathédrale Notre-Dame d'Amiens qu'ont été sacrés la plupart des rois de France."),
      Question(
          isCorrect: true,
          questionText:
          "Le Champsaur est une vallée du département des Hautes-Alpes, au nord de Gap."),

    ]);
    return listQuestions;
  }
class Question{
  String questionText;
  bool isCorrect;

  Question({required this.questionText,required this.isCorrect});

}
