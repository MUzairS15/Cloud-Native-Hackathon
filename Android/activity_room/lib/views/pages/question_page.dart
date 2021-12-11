import 'package:activity_room/consts/consts.dart';
import 'package:activity_room/controllers/question_controller.dart';
import 'package:activity_room/models/question.dart';
import 'package:activity_room/services/database_service.dart';
import 'package:activity_room/views/widgets/question_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key, required this.roomCode}) : super(key: key);
  final String roomCode;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final QuestionController questionController = Get.find();
  @override
  void initState() {
    // startTimer();
    FirebaseFirestore.instance
        .collection('live')
        .doc(widget.roomCode)
        .snapshots()
        .listen((event) {
      if (event.data() != null) {
        final String? temp = questionController.questionData.value.question;
        questionController.questionData.value =
            Question.fromSnapshot(event.data() as Map<String, dynamic>);
        print(questionController.questionData.value.question! + temp!);
        if (temp == '') {
          print("stream started;");
        } else if (questionController.questionData.value.question!
                .compareTo(temp) !=
            0) {
          questionController.questionChanges();
          QuestionWidget().createState().initState();
        }
      }
    });
    print("initstate");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("room code ${widget.roomCode}");
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: MyColors().homepagecolor,
          leading: BackButton(),
          title: Text("Questions"),
        ),
        body: GetX<QuestionController>(builder: (controller) {
          if (controller.questionData.value.question != '') {
            return QuestionWidget();
          } else {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/no_questions.jpg'),
                Text(
                  "No questions given yet!",
                  style: TextStyle(fontSize: 18, color: Color(0xFF2A1C65)),
                )
              ],
            ));
          }
        }
            // return Center(
            //   child: Text("Error occured! try again later"),
            // );
            ));
  }
}
