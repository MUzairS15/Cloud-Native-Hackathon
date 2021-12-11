import 'dart:async';

import 'package:activity_room/consts/consts.dart';
import 'package:activity_room/controllers/question_controller.dart';
import 'package:activity_room/views/widgets/option_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({Key? key, required this.scoresMap}) : super(key: key);
  final Map<String, dynamic> scoresMap;
  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final QuestionController controller = Get.find();

  void startTimer() {
    if (controller.secondsTimer.value == 0 && !controller.isTimerOn.value) {
      controller.isTimerOn.value = true;
      Timer.periodic(const Duration(seconds: 1), (t) {
        if (controller.secondsTimer.value > 600) {
          t.cancel();
          controller.isTimerOn.value = false;
        } else if (!controller.isAnswered.value) {
          controller.secondsTimer.value += 1;
        } else {
          t.cancel();
          controller.isTimerOn.value = false;
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 15),
                  child: Text(
                      "Time Elapsed : ${controller.secondsTimer.value} s",
                      style: TextStyle(
                          fontSize: 16,
                          color: MyColors().homepagecolor,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0, top: 15),
                  child: Text("Points : ${controller.questionData.value.score}",
                      style: TextStyle(
                          fontSize: 16,
                          color: MyColors().homepagecolor,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 170,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 10.0),
                  child: Text(
                    controller.questionData.value.question.toString(),
                    softWrap: true,
                    textAlign: TextAlign.start,
                    maxLines: 6,
                    style: TextStyle(fontSize: 25),
                  ),
                )),
            OptionButton(
              scoresMap: widget.scoresMap,
            ),
            SizedBox(
              height: 12.0,
            )
          ],
        ),
      );
    });
  }
}
