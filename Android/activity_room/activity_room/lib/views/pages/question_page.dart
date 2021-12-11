import 'package:activity_room/consts/consts.dart';
import 'package:activity_room/controllers/question_controller.dart';
import 'package:activity_room/models/question.dart';
import 'package:activity_room/services/database_service.dart';
import 'package:activity_room/views/widgets/question_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage(
      {Key? key, required this.roomCode, required this.scoresMap})
      : super(key: key);
  final String roomCode;
  final Map<String, dynamic> scoresMap;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final QuestionController questionController = Get.find();
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('classroom')
        .doc(widget.roomCode)
        .collection('questionLive')
        .doc('1')
        .snapshots()
        .listen((event) async {
      print(event.data());
      if (event.data() != null) {
        if (event.data()!.isNotEmpty) {
          final String? temp = questionController.questionData.value.question;

          questionController.questionData.value =
              Question.fromSnapshot(event.data() as Map<String, dynamic>);
          print(questionController.questionData.value.question! + temp!);
          // await checkIfAnswered(
          //     questionController.questionData.value.id!, questionController);
          bool val =
              await DatabaseService().getIsAttempted(widget.roomCode) ?? false;
          print(val);
          if (questionController.questionData.value.question == 'test') {
            questionController.isAnswered.value = true;
            print("initial question");
          } else if (temp == '' && val) {
            questionController.isAnswered.value = true;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text(
                "This question is already attempted!",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: MyColors().homepagecolor,
            ));
          } else if (temp == '' && !val) {
            print("Question not solved and app restared");
          } else if (questionController.questionData.value.question!
                      .compareTo(temp) !=
                  0 &&
              questionController.questionData.value.question != 'test' &&
              questionController.questionData.value.question != '') {
            questionController.questionChanges();

            QuestionWidget(
              scoresMap: widget.scoresMap,
            ).createState().initState();
          }
        } else {
          questionController.questionData.value.question = '';
        }
      }
    });

    super.initState();
  }

  // Future<void> checkIfAnswered(
  //     String? idFromDB, QuestionController questionController) async {
  //   bool? id = await DatabaseService().getIsAttempted();
  //   if (id! && questionController.questionData.value.id == '') {
  //     questionController.questionData.value.id == '';
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("This question is already attempted!")));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print("room code ${widget.roomCode}");
    return Scaffold(
        backgroundColor: Color(0xFFEBF0FC),
        appBar: AppBar(
          backgroundColor: Color(0xFFEBF0FC),
          elevation: 0.0,
          leading: BackButton(
            color: MyColors().homepagecolor,
          ),
          title: Text("Questions",
              style: TextStyle(
                color: MyColors().homepagecolor,
              )),
        ),
        body: GetX<QuestionController>(builder: (controller) {
          if (controller.questionData.value.question != '' &&
              controller.questionData.value.answer != '') {
            return QuestionWidget(
              scoresMap: widget.scoresMap,
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/no_questions.png'),
                  Text(
                    "No questions given yet!",
                    style: TextStyle(fontSize: 18, color: Color(0xFF2A1C65)),
                  )
                ],
              )),
            );
          }
        }
            // return Center(
            //   child: Text("Error occured! try again later"),
            // );
            ));
  }
}
