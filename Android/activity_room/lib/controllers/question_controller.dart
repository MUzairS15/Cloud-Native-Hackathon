import 'package:activity_room/consts/consts.dart';
import 'package:activity_room/models/question.dart';
import 'package:activity_room/services/auth_service.dart';
import 'package:activity_room/services/database_service.dart';
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
          question: '',
          option1: '',
          option2: '',
          option3: '',
          option4: '',
          answer: '',
          score: 0)
      .obs;

  void onClickButton(int index, String selectedOption) {
    colorListButton[index] = MyColors().homepagecolor; //Color(0xFF2A1C65)
    colorListText[index] = Color(0xffffffff);
    isAnswered.value = true;
    if (selectedOption == questionData.value.answer) {
      DatabaseService()
          .userDataCollection
          .doc(AuthService().getUID)
          .update({'score': questionData.value.score + totalScore.value});
      print("Your Answer is correct!");
    } else {
      print("your answer is wrong. correct is ${questionData.value.answer}");
    }
  }

  void questionChanges() {
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
    print(colorListButton);
  }
}
