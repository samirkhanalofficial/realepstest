import 'dart:convert';

import 'package:eshopbuilder/config.dart';
import 'package:eshopbuilder/provider.dart';
import 'package:eshopbuilder/skloading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'answer.dart';

class sets extends StatefulWidget {
  String id, tittle;
  sets({Key key, this.id, this.tittle}) : super(key: key);

  @override
  _homeState createState() => _homeState(id: id, tittle: tittle);
}

class _homeState extends State<sets> {
  var setss=[];
  
  String id, tittle;

  bool isloading = true;
  _homeState({this.id, this.tittle});
  PageController _controller;
  getsets() async {
    try {
      var res = await http.get("https://www.samirk.com.np/realepstest/api/questions.php?quiz_id=${id}");
      setss = json.decode(res.body.toString());
      debugPrint(setss.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {

    // TODO: implement initState
    getsets();
    _controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     var width=MediaQuery.of(context).size.width;
    return Scaffold(
          body: Center(
        child: Container(
          width: (width > 450 ? 450 : width) ,
          child:Container(
        child: ChangeNotifierProvider<answerchecker>(
          create: (context) => answerchecker(setss,context),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              
              leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
              title: Text(
                tittle,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            body: isloading
                ? skloading()
                : setss.length == 0 ? error() : PageView.builder(
                    controller: _controller,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: setss.length,
                    itemBuilder: (context, i) {
                      return answer(
                        controller: _controller,
                        page: i + 1,
                        correctanswer: setss[i]["correct_option"],
                        id:setss[i]["id"],
                        islastpage: (i + 1 == setss.length) ? true : false,
                        title: setss[i]["feedback"],
                        question: setss[i]["title"],
                        type: setss[i]["type"],
                        audiourl: setss[i]["audio"],
                        imageurl: setss[i]["picture"],
                        answers: [
                          setss[i]["option1"],
                          setss[i]["option2"],
                          setss[i]["option3"],
                          setss[i]["option4"],
                        ],
                      );
                    }),
          ),
        ),
      ))),
    );
  }
}
