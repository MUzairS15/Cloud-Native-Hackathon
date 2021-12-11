import 'package:activity_room/controllers/question_controller.dart';
import 'package:activity_room/models/question.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionButton extends StatelessWidget {
  OptionButton({
    Key? key,
    required this.scoresMap,
  }) : super(key: key);
  final Map<String, dynamic> scoresMap;
  final QuestionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          String buttonText =
              controller.getOptions(index, controller.questionData.value);
          return Obx(() {
            return IgnorePointer(
              ignoring: controller.isAnswered.value,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Material(
                    borderRadius: BorderRadius.circular(5.0),
                    elevation: 11,
                    shadowColor: Color(0xFFEBF0FC),
                    child: GestureDetector(
                      onTap: () => onAnswered(index),
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.82,
                        decoration: BoxDecoration(
                            color: controller.colorListButton[index]),
                        child: Center(
                            child: Text(
                          buttonText,
                          style: TextStyle(
                              color: controller.colorListText[index],
                              fontSize: 16),
                        )),
                      ),
                    )),
              ),
            );
          });
        });
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

  onAnswered(index) {
    print(index);
    String selectedOption = getOptions(index, controller.questionData.value);
    controller.onClickButton(index, selectedOption, scoresMap);
  }
}
