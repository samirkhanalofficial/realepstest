import 'dart:convert';

import 'package:eshopbuilder/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'config.dart';
import 'sets.dart';
import 'skloading.dart';

class setspage extends StatefulWidget {
  setspage({Key key}) : super(key: key);

  @override
  _setspageState createState() => _setspageState();
}

class _setspageState extends State<setspage> {
  List setss=[];
  bool isloading=true;
  getsets() async {
    try{
    var res=await http.post("https://www.samirk.com.np/realepstest/api/quiz.php");
    setss=json.decode(res.body);
    debugPrint("test Print"+setss.toString());
    }catch(e){
debugPrint(e.toString());
    }
    setState(() {
      isloading=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getsets();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     var width=MediaQuery.of(context).size.width;
    return Scaffold(
          body: Center(
        child: Container(
          width: (width > 450 ? 450 : width) ,
          child:Scaffold(
          
          appBar: AppBar(
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
            title: Text(
              "Sets",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            centerTitle: true,
          ),
          body: isloading ? skloading():  setss.length == 0 ? error() :ListView.builder(
            padding: EdgeInsets.all(8),
            physics: BouncingScrollPhysics(),
            itemCount: setss.length,
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 2,
            //   crossAxisSpacing: 8,
            //   mainAxisSpacing: 8,
            // ),
            itemBuilder: (context, i) => _actionbutton(
                title: setss[i]["title"],
                icon: MdiIcons.library,
                color: Colors.blue.withOpacity(0.5),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => sets(id: setss[i]["id"],tittle: setss[i]["title"],)));
                }),
          )))),
    );
  }

  Widget _actionbutton({String title, IconData icon, var onTap, Color color}) {
    return Card(
      margin: EdgeInsets.all(3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
        contentPadding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 12,),
        onTap:()=> onTap(),
           leading: Icon(
              icon,
              size: 55,
              color: Colors.redAccent,
            ),
           title: Text(title),
          ),
    );
  }
}
