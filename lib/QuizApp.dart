import 'dart:async' show Future;
import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dataStructures.dart';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  QuizCard currentQuestion ;
  bool loadQuestion  = true;
  bool dataLoaded = false;
  bool checkingAnswer = false;
  List<Country> countryData = [];
  List<Country> leftCountry = [];
  List<Country> doneCountry = [];

  Color backgroundColor = Colors.black12;
  List<IconData> optionIcons = <IconData>[Icons.check_circle_outline, Icons.check_circle_outline, Icons.check_circle_outline, Icons.check_circle_outline];
  List<Color> optionIconsColors = <Color>[Colors.black,Colors.black,Colors.black,Colors.black];

  void initState(){
    loadData();
  }
  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }
  loadData() async{
    String data = await getFileData('assets/mainJson.json');
    var jsonBody = json.decode(data);
    for (var data in jsonBody){
      countryData.add(new Country(data['country'], data['capital'], data['CC'], data['photo']));
      leftCountry.add(new Country(data['country'], data['capital'], data['CC'], data['photo']));
    }
    setState(() {
      dataLoaded = true;
    });
    print("DATA LOADED!!!");
  }
  QuizCard returnOneCountry(){
    loadQuestion = false;
    int index  = Random().nextInt(leftCountry.length);
    int correctResponse = Random().nextInt(4);
    Country temp = leftCountry[index];
    leftCountry.removeAt(index);
    doneCountry.add(temp);

    return new QuizCard(temp.country, temp.cCode, temp.photo, returnOptions(temp.capital,correctResponse), correctResponse);
  }

  List<String> returnOptions(String capital, int correctResponse){
    List <String> optionList = [];
    while(optionList.length!=4){
      int index = Random().nextInt(countryData.length);
      if (!optionList.contains(countryData[index].capital)){
        optionList.add(countryData[index].capital);
      }
    }
    optionList[correctResponse] = capital;
    return optionList;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Capital Generator",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: _cardWidget(),
    ) ;
  }

  Widget _cardWidget(){
    return Container(
        margin: EdgeInsets.only(top:30,bottom: 40,right: 20, left:20),
        child: Card(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          child: _getFlag(),
        )
    );

  }
  Widget _getFlag(){
    if(!dataLoaded){
      return Center(
          child:Text("LOADINGG!!!!")
      );
    }
    if(loadQuestion){
      currentQuestion = returnOneCountry();
    }
    return Center (
      child:Column(

        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            child: Card(
                margin: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child:Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(currentQuestion.photo, fit:BoxFit.fill),
                    )
                )
            ),
          )
          ,
          Container(
              margin: EdgeInsets.all(10),
              child:Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: new InkWell(
                  child: Text(currentQuestion.country, textAlign: TextAlign.center, textScaleFactor: 2),
                ),
              )
          )
          ,

          Expanded(
              child: Container(
                  margin: EdgeInsets.all(10),
                  child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: _listV()
                  )
              )
          ),
        ],
      )
      ,
    );
  }
  void restoreDefaults(){
    optionIcons = <IconData>[Icons.check_circle_outline, Icons.check_circle_outline, Icons.check_circle_outline, Icons.check_circle_outline];
    optionIconsColors = <Color>[Colors.black,Colors.black,Colors.black,Colors.black];
  }
  void checkAnswer(int option ){
    if(option == currentQuestion.correctAnswer){
      setState(() {
        optionIcons[option] = Icons.check_circle;
        optionIconsColors[option] = Colors.green;
        backgroundColor = Colors.greenAccent;
      });
    }
    else{
      setState(() {
        optionIcons[currentQuestion.correctAnswer] = Icons.check_circle_outline;
        optionIconsColors[currentQuestion.correctAnswer] = Colors.green;
        backgroundColor = Colors.redAccent;
        optionIconsColors[option] = Colors.red;
      });
    }

    Future.delayed(const Duration(milliseconds: 1000), () {
      restoreDefaults();
      setState(() {
        backgroundColor = Colors.black12;
        loadQuestion = true;
        checkingAnswer = false;
      });
    });

  }
  Widget _listV() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Card(
          child: InkWell(
            child: ListTile(
              title: Text(currentQuestion.options[0]),
              onTap: (){
                if(!checkingAnswer){
                  checkingAnswer = true;
                  checkAnswer(0);
                }
              },
              leading: Icon(
                  optionIcons[0],
                  color: optionIconsColors[0]
              ),
            ),
          ),
        ),
        Card(
          child: InkWell(
            child: ListTile(
              title: Text(currentQuestion.options[1]),
              onTap: (){
                if(!checkingAnswer){
                  checkingAnswer = true;
                  checkAnswer(1);
                }
              },
              leading: Icon(
                  optionIcons[1],
                  color: optionIconsColors[1]
              ),
            ),
          ),
        ),
        Card(
          child: InkWell(
            child: ListTile(
              title: Text(currentQuestion.options[2]),
              onTap: (){
                if(!checkingAnswer){
                  checkingAnswer = true;
                  checkAnswer(2);
                }
              },
              leading: Icon(
                  optionIcons[2],
                  color: optionIconsColors[2]
              ),
            ),
          ),
        ),
        Card(
          child: InkWell(
            child: ListTile(
              title: Text(currentQuestion.options[3]),
              onTap: (){
                if(!checkingAnswer){
                  checkingAnswer = true;
                  checkAnswer(3);
                }
              },
              leading: Icon(
                  optionIcons[3],
                  color: optionIconsColors[3]
              ),
            ),
          ),
        )
      ],
    );
  }
  Widget optionCard(index){
    return Card(
      child: InkWell(
        child: ListTile(
          title: Text(currentQuestion.options[index]),
          onTap: (){
            if(!checkingAnswer){
              checkingAnswer = true;
              checkAnswer(index);
            }
          },
          leading: Icon(
              optionIcons[index],
              color: optionIconsColors[index]
          ),
        ),
      ),
    );
  }
}
