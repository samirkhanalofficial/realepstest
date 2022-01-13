import 'package:flutter/material.dart';

class answerchecker extends ChangeNotifier {
  var datafromapi, context;
  List<answerrrr> wrongs = [];
  answerchecker(this.datafromapi, this.context);
  var score = 0;
  void increase(id) {
    score = score + 1;

    if (wrongs.length > datafromapi.length) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("You cannot edit submitted Answer"),
                content:
                    Text("Please replay from start to resubmmit your answer."),
              ));
    } else {
      wrongs.add(answerrrr(id, true));
    }

    notifyListeners();
  }

  getscore() {
    return score;
  }

  getdata() {
    return datafromapi;
  }

  reset() {
    score = 0;
  }

  wrongid(id) {
    if (wrongs.length > datafromapi.length) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("You cannot edit submitted Answer"),
                content:
                    Text("Please replay from start to resubmmit your answer."),
              ));
    } else {
      wrongs.add(answerrrr(id, false));
    }
  }

  getwrongdata() {
    return wrongs;
  }
}

class answerrrr {
  var id;
  bool iswrong;
  answerrrr(this.id, this.iswrong);
}
