import 'package:eshopbuilder/home.dart';
import 'package:flutter/material.dart';
import 'config.dart';

main() {
  runApp(MaterialApp(
    theme: ThemeData(
        appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      color: Colors.white,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontSize: 25,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.black,
      ),
    )),
    title: appname,
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
