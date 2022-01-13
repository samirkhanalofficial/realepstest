import 'package:audioplayer/audioplayer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshopbuilder/provider.dart';
import 'package:eshopbuilder/resultanswer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class answer extends StatefulWidget {
  int page;
  var id;
  String title, question, imageurl, audiourl, type;
  List<String> answers;
  bool islastpage;
  PageController controller;
  String correctanswer;
  answer({
    Key key,
    this.page,
    this.controller,
    this.title,
    this.question,
    this.answers,
    this.islastpage,
    this.correctanswer,
    this.type,
    this.imageurl,
    this.audiourl,
    this.id,
  }) : super(key: key);

  @override
  _answerState createState() => _answerState(
        page: page,
        controller: controller,
        title: title,
        question: question,
        answers: answers,
        islastpage: islastpage,
        correctanswer: correctanswer,
        type: type,
        imageurl: imageurl,
        audiourl: audiourl,
        id: id,
      );
}

class _answerState extends State<answer> with SingleTickerProviderStateMixin {
  String correctanswer, imageurl, audiourl, type;
  int page;
  var id;
  bool islastpage;
  PageController controller;
  String title, question;
  List<String> answers;
  int selected_answer = 0;
  AudioPlayer audioplayer;
  AnimationController _animationController;
  var score;
  var data;
  bool hasalreadydone = false;
  bool isplaying = false;
  _answerState({
    this.page,
    this.controller,
    this.title,
    this.question,
    this.answers,
    this.islastpage,
    this.correctanswer,
    this.type,
    this.imageurl,
    this.audiourl,
    this.id,
  });

  playanimation() {
    _animationController.forward();
  }

  stopanimation() {
    _animationController.reverse();
  }

  playaudio() {
    if (isplaying) {
      stopaudio();
      isplaying = false;
    } else {
      playanimation();
      audioplayer.play(audiourl);
      isplaying = true;
    }
  }

  stopaudio() {
    audioplayer.stop();
    stopanimation();
  }

  checkstate() {
    audioplayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.COMPLETED) {
        stopaudio();
      }
    });
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );
    audioplayer = AudioPlayer();
    checkstate();
    super.initState();
  }

  @override
  void dispose() {
    audioplayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<answerchecker>(
      builder: (context, myModel, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            children: [
              Card(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  elevation: 0,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("$page) $title .",
                        style: GoogleFonts.nanumGothicCoding(
                          textStyle: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        )),
                  )),
            ],
          ),
          Expanded(
            child: Center(
              child: ListView(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: (type == "image")
                                ? AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: CachedNetworkImage(
                                      imageUrl: imageurl,
                                      placeholder: (a, b) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  )
                                : (type == "audio")
                                    ? Container(
                                        width: double.infinity,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: AnimatedIcon(
                                                    icon: AnimatedIcons
                                                        .play_pause,
                                                    progress:
                                                        _animationController),
                                                onPressed: () {
                                                  playaudio();
                                                },
                                              ),
                                              Text("AudioFile"),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Text(
                                        "$question",
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.nanumGothicCoding(
                                            textStyle: TextStyle(
                                          fontSize: 20,
                                          height: 1.5,
                                          fontWeight: FontWeight.bold,
                                        )),
                                      ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(75),
                    topRight: Radius.circular(75),
                  )),
                  margin: EdgeInsets.all(0),
                  color: Colors.white,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        //     SizedBox(
                        //   width: 50,
                        //   height: 15,
                        //                           child: Card(
                        //                             elevation: 0.5,
                        //     color: Colors.grey.shade200,
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),

                        for (int i = 0; i < 4; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  selected_answer = i + 1;
                                });
                                if (hasalreadydone) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(
                                                "You cannot edit submitted Answer"),
                                            content: Text(
                                                "Please replay from start to resubmmit your answer."),
                                            actions: [
                                              FlatButton(
                                                child: Text("REPLAY"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          ));
                                } else {
                                  if ("option" + selected_answer.toString() ==
                                      correctanswer) {
                                    myModel.increase(id);
                                  } else {
                                    myModel.wrongid(id);
                                  }
                                  if (islastpage) {
                                    var score = myModel.getscore();
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => resultanswer(
                                                  score: score,
                                                  data: myModel.getdata(),
                                                  wrongdata:
                                                      myModel.getwrongdata(),
                                                )));
                                    myModel.reset();
                                  } else {
                                    controller.animateToPage(page,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOutSine);
                                  }
                                }
                                hasalreadydone = true;
                              },
                              child: Container(
                                margin: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    gradient: LinearGradient(colors: [
                                      Colors.pink,
                                      Colors.red,
                                    ])),
                                child: Container(
                                    padding: EdgeInsets.all(1),
                                    child: ListTile(
                                      title: Text(answers[i],
                                          style: GoogleFonts.nanumGothicCoding(
                                            textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              height: 1.5,
                                              color: Colors.white,
                                            ),
                                          )),
                                      trailing: ClipOval(
                                          child: Container(
                                              color:
                                                  (selected_answer == (i + 1))
                                                      ? Colors.green
                                                      : Colors.grey.shade200,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: InkWell(
                                                  child: SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: Center(
                                                        child: (selected_answer ==
                                                                (i + 1))
                                                            ? Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              )
                                                            : Text((i + 1)
                                                                .toString())),
                                                  ),
                                                ),
                                              ))),
                                    )),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // (page == 20)
          //     ? SizedBox(
          //         height: 10,
          //       )
          //     : SizedBox.shrink(),
          // islastpage
          //     ? Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: RaisedButton(
          //           padding: EdgeInsets.all(18),
          //           color: Colors.green,
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(25)),
          //           onPressed: () async {

          //           },
          //           child: Text(
          //             "Submit Answer",
          //             style: TextStyle(color: Colors.white),
          //           ),
          //         ),
          //       )
          //     : SizedBox.shrink(),
        ],
      ),
    );
  }
}
