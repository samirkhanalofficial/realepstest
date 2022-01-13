import 'package:flutter/material.dart';

import 'config.dart';

Widget skloading(){
  return  Center(child: Theme(data: ThemeData(accentColor: Colors.black,),child: CircularProgressIndicator())) ;
}
Widget error(){
  return  Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(Icons.error,size: 50,),
      Text("No Internet",style: TextStyle(fontSize: 17,),),
    ],
  )) ;
}