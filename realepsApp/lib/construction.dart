import 'package:flutter/material.dart';

class construction extends StatefulWidget {
  construction({Key key}) : super(key: key);

  @override
  _constructionState createState() => _constructionState();
}

class _constructionState extends State<construction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(title: Text("Under Construction"),),
       body: Center(
         child:Image.asset("assets/download.jpg"),
       ),
    );
  }
}