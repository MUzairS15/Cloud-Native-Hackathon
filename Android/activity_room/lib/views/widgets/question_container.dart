import 'dart:async';

import 'package:activity_room/controllers/question_controller.dart';
import 'package:activity_room/views/widgets/option_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionWidget extends StatefulWidget {
  QuestionWidget({Key? key}) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final QuestionController controller = Get.find();

  void startTimer() {
    if (controller.secondsTimer.value == 0) {
      Timer.periodic(const Duration(seconds: 1), (t) {
        if (controller.secondsTimer.value > 600) {
          t.cancel();
        } else if (!controller.isAnswered.value) {
          controller.secondsTimer.value += 1;
        } else {
          t.cancel();
        }
      });
    }
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<QuestionController>(builder: (controller) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 15),
                  child: Text("Time used : ${controller.secondsTimer.value} s",
                      style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0, top: 15),
                  child: Text("Points : ${controller.questionData.value.score}",
                      style: TextStyle(fontSize: 16)),
                )
              ],
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 170,
                child: Center(
                  child: Text(
                    controller.questionData.value.question.toString(),
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                )),
            OptionButton(
                buttonText: controller.questionData.value.option1.toString(),
                buttonColor: controller.colorListButton[0],
                textColor: controller.colorListText[0],
                index: 0),
            OptionButton(
                buttonText: controller.questionData.value.option2.toString(),
                buttonColor: controller.colorListButton[1],
                textColor: controller.colorListText[1],
                index: 1),
            OptionButton(
                buttonText: controller.questionData.value.option3.toString(),
                buttonColor: controller.colorListButton[2],
                textColor: controller.colorListText[2],
                index: 2),
            OptionButton(
                buttonText: controller.questionData.value.option4.toString(),
                buttonColor: controller.colorListButton[3],
                textColor: controller.colorListText[3],
                index: 3),
            SizedBox(
              height: 12.0,
            )
          ],
        ),
      );
    });
  }
}
