import 'package:eshopbuilder/books.dart';
import 'package:eshopbuilder/setspage.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'config.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          width: (width > 450 ? 450 : width),
          child: Scaffold(
              // drawer: Drawer(
              //   key: Key('drawer'),
              //   child: ListView(
              //     children:[
              //       DrawerHeader(
              //         margin: EdgeInsets.all(0),
              //         padding: EdgeInsets.all(0),
              //        child: Container(
              //          color: Colors.red,
              //        ),
              //       ),
              //     ],
              //   ),
              // ),
              appBar: AppBar(
                  title: Text(
                    appname,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AboutDialog(
                                    applicationIcon: SizedBox(
                                        width: 100,
                                        child:
                                            Image.asset("assets/mainlogo.png")),
                                    applicationName: 'Real EPS Test',
                                    applicationVersion: "v1.0.0",
                                    children: [
                                      Text(
                                        "Founder / CEO : Devendra Pokhrel",
                                        style: TextStyle(
                                            color: Colors.grey.shade500),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            launch("https://samirk.com.np");
                                          },
                                          child: Text(
                                            "Backend: Samir Khanal",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          )),
                                      SizedBox(height: 20),
                                      RaisedButton(
                                          color: Colors.black,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          onPressed: () {
                                            launch("https://samirk.com.np");
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "App Developer: Samir Khanal",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ],
                                  ));
                        }),
                  ]),
              body: ListView(
                  padding: EdgeInsets.all(8),
                  physics: BouncingScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _actionbutton(
                            title: "CBT(General)",
                            icon: MdiIcons.library,
                            color: Colors.redAccent,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => setspage()));
                            }),
                        _actionbutton(
                            title: "EPS Books",
                            icon: MdiIcons.bookshelf,
                            color: Colors.blue,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Books(
                                        type: 'book',
                                      )));
                            }),
                      ],
                    ),
                    _actionbutton(
                        title: "Grammer",
                        icon: MdiIcons.book,
                        color: Colors.green,
                        aspectratio: 16 / 9,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Books(
                                    type: 'grammar',
                                  )));
                        }),
                    // _actionbutton(
                    //     title: "EPS Questions",
                    //     icon: MdiIcons.bookCheck,
                    //     color: Colors.green,
                    //     aspectratio: 16 / 9,
                    //     onTap: () {
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //           builder: (context) => construction()));
                    //     }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _actionbutton(
                            title: "Useful Verbs",
                            icon: MdiIcons.frequentlyAskedQuestions,
                            color: Colors.orange,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Books(
                                        type: 'verbs',
                                      )));
                            }),
                        _actionbutton(
                            title: "Vocabulary",
                            icon: MdiIcons.book,
                            color: Colors.purple,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Books(
                                        type: 'vocabulary',
                                      )));
                            }),
                      ],
                    ),
                  ])),
        ),
      ),
    );
  }

  Widget _actionbutton(
      {String title, IconData icon, var onTap, Color color, var aspectratio}) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      child: AspectRatio(
        aspectRatio: aspectratio == null ? 1 : aspectratio,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: InkWell(
            onTap: () {
              onTap();
            },
            child: aspectratio == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(
                          icon,
                          size: 55,
                          color: color,
                        ),
                        Text(title),
                      ])
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        icon,
                        size: 100,
                        color: color,
                      ),
                      Text(
                        title,
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
