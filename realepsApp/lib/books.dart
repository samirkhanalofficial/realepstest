import 'dart:convert';

import 'package:eshopbuilder/pdfviewer.dart';
import 'package:eshopbuilder/skloading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Books extends StatefulWidget {
  var type;
  Books({Key key,@required this.type}) : super(key: key);

  @override
  _BooksState createState() => _BooksState(type);
}

class _BooksState extends State<Books> {
  var books;
  var type;
  bool loading = true;
  _BooksState(this.type);
  load() async {
    try {
      var res =
          await get("https://www.samirk.com.np/realepstest/api/books.php?categ="+type);
      books = jsonDecode(res.body.toString());
    } catch (e) {}
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RealEPS $type"),
      ),
      body: loading
          ? skloading()
          : books == null
              ? error()
              : books.length <1 ? Center(child:SizedBox(height:50,width:50,child:Text("No files found"))):ListView.builder(physics: BouncingScrollPhysics(),itemCount: books.length,itemBuilder: (context,i){
                return _book(title: books[i]["book_title"],icon: Icons.picture_as_pdf,author:books[i]["type"],link:books[i]["book_link"],context:context);
              }),
    );
  }
}
Widget _book({String title,String author, IconData icon,String link, BuildContext context, Color color}) {
    return Card(
      margin: EdgeInsets.all(3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        subtitle: Text("$author"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
        contentPadding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 12,),
        onTap:(){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PdfViewer(title: title,link:link)));
        },
           leading: Icon(
              icon,
              size: 55,
              color: Colors.redAccent,
            ),
           title: Text(title),
          ),
    );
  }

