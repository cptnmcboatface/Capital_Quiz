import 'package:flutter/material.dart';
import 'dataStructures.dart';
import 'package:capital_quiz/QuizApp.dart';



void main(){
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Background color transition',
      debugShowCheckedModeBanner: false,
      home: MyMainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyMainPage extends StatefulWidget {
  MyMainPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }



  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Scaffold(
            body: Container(
              color: background.evaluate(AlwaysStoppedAnimation(_controller.value)),
              child: Container(
                  margin: EdgeInsets.only(top:80,bottom: 80,right: 30, left:30),
                  color: Colors.white24,
                  child:  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          margin:EdgeInsets.all(30),
                          child: Image.asset("assets/images/MainScreenIcon.png"),
                        )
                        ,
                        Opacity(
                          opacity: 0.9,
                          child: FlatButton(
//                            color: Colors.white24,
                            child: Text('Start Quiz',
                              style: TextStyle(
//                                  decoration: TextDecoration.underline,
                                  fontSize: 30,
                                  fontFamily: 'Kranky',
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()),
                              );
                            },
                          ),
                        ),
                        Opacity(
                          opacity: 0.4,
                          child: FlatButton(
                            child: Text('Country of the Day',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Kranky',
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  )

              ),
            ),
          );
        });
  }
}

