import 'package:flutter/material.dart';

class resultanswer extends StatefulWidget {
  var score, data, wrongdata;
  resultanswer({Key key, this.score, this.data, this.wrongdata})
      : super(key: key);

  @override
  _resultanswerState createState() =>
      _resultanswerState(score: score, data: data,wrongdata: wrongdata);
}

class _resultanswerState extends State<resultanswer> {
  var score, data, wrongdata;
  _resultanswerState({this.score, this.data, this.wrongdata});
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
          body: Center(
        child: Container(
          width: (width > 450 ? 450 : width) ,
          child:Scaffold(
        appBar: AppBar(
          
          title: Text("Result"),
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
      
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
                child: Text(
              "You Scored",
              style: TextStyle(
                color: Colors.red,
                fontSize: 30,
              ),
            )),
            Center(
                child: Text(
              score.toString() + " of " + data.length.toString(),
              style: TextStyle(color: Colors.black, fontSize: 25, shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 1,
                )
              ]),
            )),
            SizedBox(
              height: 150,
            ),
            Container(
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Center(
                        child: Theme(
                          data: ThemeData(
                            accentColor: Colors.lightGreen,
                          ),
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.grey.shade200,
                            value: (score / data.length),
                            strokeWidth: 200,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Revise:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Questions You Attempted : ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            for (int i = 0; i < data.length; i++)
              Container(
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[i]["title"],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          data[i][data[i]["correct_option"]],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (wrongdata[i]?.iswrong== true) ?  Colors.green : Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    )));
  }
}
