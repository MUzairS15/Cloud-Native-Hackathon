import 'package:activity_room/controllers/question_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionButton extends StatelessWidget {
  OptionButton(
      {Key? key,
      required this.buttonText,
      required this.textColor,
      required this.buttonColor,
      required this.index})
      : super(key: key);
  final String buttonText;
  final Color textColor;
  final Color buttonColor;
  final int index;

  final QuestionController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: c.isAnswered.value,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
            borderRadius: BorderRadius.circular(5.0),
            elevation: 11,
            shadowColor: Colors.black,
            child: GestureDetector(
              onTap: () {
                c.onClickButton(index, buttonText);
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.82,
                decoration: BoxDecoration(color: buttonColor),
                child: Center(
                    child: Text(
                  buttonText,
                  style: TextStyle(color: textColor, fontSize: 16),
                )),
              ),
            )),
      ),
    );
  }
}
