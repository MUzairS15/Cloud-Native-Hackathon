import 'package:activity_room/consts/consts.dart';
import 'package:activity_room/controllers/question_controller.dart';
import 'package:activity_room/models/user.dart';
import 'package:activity_room/services/database_service.dart';
import 'package:activity_room/views/pages/attendence_page.dart';
import 'package:activity_room/views/pages/question_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RoomPage extends StatelessWidget {
  RoomPage({Key? key, required this.snapshot}) : super(key: key);
  AsyncSnapshot snapshot;
  final QuestionController questionController = Get.put(QuestionController());
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> scoresMap =
        snapshot.data['scores'] as Map<String, dynamic>;

    print(scoresMap.keys);
    return Scaffold(
      backgroundColor: Color(0xFFEBF0FC),
      appBar: AppBar(
        shadowColor: Color(0xFFEBF0FC),
        elevation: 0,
        backgroundColor: Color(0xFFEBF0FC),
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
              padding: const EdgeInsets.only(right: 15.0, top: 15.0),
              child: FaIcon(
                FontAwesomeIcons.signOutAlt,
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
              padding: const EdgeInsets.only(top: 7.0),
              child: Material(
                color: MyColors().homepagecolor,
                borderRadius: BorderRadius.circular(5.0),
                elevation: 5,
                shadowColor: Colors.black,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Room Code : ${snapshot.data['roomCode']}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Subject Name : " + snapshot.data['roomSubject'],
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: SizedBox(
                height: scoresMap.isEmpty ? 20 : 100,
                child: ListView.builder(
                    itemCount: scoresMap.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Material(
                          color: MyColors().homepagecolor,
                          borderRadius: BorderRadius.circular(5.0),
                          elevation: 5,
                          shadowColor: Colors.black,
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.86,
                              child: ListTile(
                                title: Text(
                                  scoresMap.keys.toList()[index].toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                      "Your Score : " +
                                          scoresMap[scoresMap.keys
                                                  .toList()[index]
                                                  .toString()]
                                              .toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                ),
                                leading: const FaIcon(FontAwesomeIcons.bookOpen,
                                    color: Colors.white),
                              )),
                        ),
                      );
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
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
                                scoresMap: scoresMap)));
                        questionController.totalScore.value = snapshot
                            .data['scores'][snapshot.data['roomSubject']];
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.43,
                        height: 120,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.question,
                              color: Colors.white,
                            ),
                            Text(
                              "Solve\nQuestions",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AttendencePage(
                                roomCode: snapshot.data['roomCode'],
                              )));
                      // User user = await DatabaseService().getUserData();
                      // print(user.email.toString() +
                      //     user.name.toString() +
                      //     user.prn.toString() +
                      //     user.uid.toString());
                    },
                    child: Material(
                      color: MyColors().homepagecolor,
                      borderRadius: BorderRadius.circular(5.0),
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.43,
                        height: 120,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.users,
                              color: Colors.white,
                            ),
                            Text(
                              "Mark\nAttendance",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
