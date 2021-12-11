import 'package:activity_room/consts/consts.dart';
import 'package:activity_room/controllers/question_controller.dart';
import 'package:activity_room/services/database_service.dart';
import 'package:activity_room/views/pages/question_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RoomPage extends StatelessWidget {
  RoomPage({Key? key, required this.snapshot}) : super(key: key);
  AsyncSnapshot snapshot;
  final QuestionController questionController = Get.put(QuestionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: MyColors().homepagecolor,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          'Activity Room',
          style: GoogleFonts.openSans(
              color: MyColors().homepagecolor,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              DatabaseService().leaveRoom();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.logout_outlined,
                color: MyColors().homepagecolor,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Material(
                color: MyColors().homepagecolor,
                borderRadius: BorderRadius.circular(5.0),
                elevation: 5,
                shadowColor: Colors.black,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 55,
                  child: Center(
                      child: Text(
                    "Your total Score : ${snapshot.data['score']}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Material(
                color: MyColors().homepagecolor,
                borderRadius: BorderRadius.circular(5.0),
                elevation: 5,
                shadowColor: Colors.black,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 70,
                  child: Center(
                      child: Text(
                    "Room Code : ${snapshot.data['roomCode']}\nSubject Name : DM",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Material(
                color: MyColors().homepagecolor,
                borderRadius: BorderRadius.circular(5.0),
                elevation: 5,
                shadowColor: Colors.black,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuestionPage(
                              roomCode: snapshot.data['roomCode'],
                            )));
                    questionController.totalScore.value =
                        snapshot.data['score'];
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 60,
                    child: Center(
                        child: Text(
                      "Solve Questions",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
