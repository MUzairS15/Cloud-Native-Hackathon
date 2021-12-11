import 'package:activity_room/consts/consts.dart';
import 'package:activity_room/models/question.dart';
import 'package:activity_room/services/auth_service.dart';
import 'package:activity_room/services/database_service.dart';
import 'package:activity_room/services/notification_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController {
  var colorListButton =
      <Color>[Colors.white, Colors.white, Colors.white, Colors.white].obs;
  var colorListText =
      <Color>[Colors.black, Colors.black, Colors.black, Colors.black].obs;
  var isAnswered = false.obs;
  var secondsTimer = 0.obs;
  var totalScore = 0.obs;

  var questionData = Question(
          type: '',
          question: '',
          option1: '',
          option2: '',
          option3: '',
          option4: '',
          answer: '',
          score: 0)
      .obs;

  void onClickButton(
      int index, String selectedOption, Map<String, dynamic> scoresMap) async {
    colorListButton[index] = MyColors().homepagecolor; //Color(0xFF2A1C65)
    colorListText[index] = Color(0xffffffff);
    isAnswered.value = true;
    if (selectedOption == questionData.value.answer) {
      String sub = await DatabaseService().getSubject();
      scoresMap[sub] = questionData.value.score + totalScore.value;
      DatabaseService()
          .userDataCollection
          .doc(AuthService().getUID)
          .update({'scores': scoresMap});

      print("Your Answer is correct!");
      print(questionData.value);
      DatabaseService().saveIsAttempted(isAnswered.value);
      await DatabaseService().sendResponseToDB(true, secondsTimer.value);
    } else {
      print("your answer is wrong. correct is ${questionData.value.answer}");
      DatabaseService().saveIsAttempted(isAnswered.value);
      await DatabaseService().sendResponseToDB(false, secondsTimer.value);
    }
  }

  Future<void> questionChanges() async {
    colorListButton.value = <Color>[
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white
    ];
    colorListText.value = <Color>[
      Colors.black,
      Colors.black,
      Colors.black,
      Colors.black
    ];
    isAnswered.value = false;
    secondsTimer.value = 0;
    await NotificationApi().getPermissions();
    String sub = await DatabaseService().getSubject();
    await NotificationApi().showNotification(
        'key', sub.toString(), 'New Question has been added!');
    DatabaseService().saveIsAttempted(false);
    print(colorListButton);
  }

  String getOptions(int index, Question question) {
    switch (index) {
      case 0:
        return question.option1.toString();

      case 1:
        return question.option2.toString();

      case 2:
        return question.option3.toString();

      case 3:
        return question.option4.toString();

      default:
        return 'Null';
    }
  }
}
