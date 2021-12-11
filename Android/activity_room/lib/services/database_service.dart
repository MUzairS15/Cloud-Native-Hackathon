// ignore_for_file: avoid_print

import 'package:activity_room/models/user.dart';
import 'package:activity_room/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference liveQuestionsCollection =
      FirebaseFirestore.instance.collection('live');
  final CollectionReference classroomCollection =
      FirebaseFirestore.instance.collection('classroom');
  final String uid = AuthService().getUID;

  User makeUserForDB(String name, String prn, String email) {
    return User(name: name, prn: prn, email: email, uid: uid, scores: {});
  }

  Future<void> addUserToDB(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userDataCollection.doc(uid).set({
      'Name': user.name,
      'PRN': user.prn,
      'Email': user.email,
      'UID': user.uid,
      'isAttendingClass': user.isAttendingClass,
      'isTeacher': user.isTeacher,
      'roomCode': user.roomCode,
      'roomSubject': user.roomSubject,
      'scores': user.scores
    });
    await prefs.setString('Name', user.name.toString());
    await prefs.setString('PRN', user.prn.toString());
    await prefs.setString('Email', user.email.toString());
    await prefs.setString('UID', user.uid.toString());
  }

  // join the room using code entered by the user
  Future<void> addRoomCodeToDB(String? code, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String subName = 'Unknown';
      await prefs.setString('roomCode', code ?? "AAAAAA");
      await classroomCollection
          .doc(code.toString().trim())
          .get()
          .then((DocumentSnapshot value) async {
        await prefs.setString("roomSubject", value['name'] ?? 'Unknown');
      });

      await userDataCollection
          .doc(uid)
          .get()
          .then((DocumentSnapshot value) async {
        final Map<String, dynamic> map = value['scores'];
        subName = prefs.getString('roomSubject')!;
        if (!map.keys.toList().contains(subName.trim())) {
          map[subName] = 0;
          await userDataCollection.doc(uid).update({
            'isAttendingClass': true,
            'roomCode': code,
            'roomSubject': subName,
            'scores': map
          });
        } else {
          await userDataCollection.doc(uid).update({
            'isAttendingClass': true,
            'roomCode': code,
            'roomSubject': subName
          });
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Code!')));
    }
  }

  Future<void> leaveRoom() async {
    try {
      userDataCollection
          .doc(uid)
          .update({'isAttendingClass': false, 'roomCode': ''});
    } catch (e) {
      print(e);
    }
  }

  Future<String> getSubject() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString('roomSubject'));
    return pref.getString('roomSubject')!;
  }

  Future<String> getRoomCode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString('roomCode'));
    return pref.getString('roomCode')!;
  }

  Future<User> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name, email, prn, uid;
    name = prefs.getString('Name');
    prn = prefs.getString('PRN');
    email = prefs.getString('Email');
    uid = prefs.getString('UID');
    final user = User(name: name, prn: prn, email: email, uid: uid, scores: {});
    return user;
  }

  // Future<String> getSubjectFromRoomCode(String roomCode) async {
  //   DocumentSnapshot snapshot =
  //       await liveQuestionsCollection.doc(roomCode).get();

  //   return snapshot['name'];
  // }

  Future<void> updateUserInfo(String name, String email, String prn) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await userDataCollection
          .doc(uid)
          .update({'Name': name, 'Email': email, 'PRN': prn});
      await prefs.setString('Name', name);
      await prefs.setString('PRN', prn);
      await prefs.setString('Email', email);
    } catch (e) {
      print(e);
    }
  }

  String getTimeForResponses() {
    List months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ];
    final day = DateTime.now().day;
    final String month = months[DateTime.now().month - 1];
    final time = DateTime.now();
    return (day.toString() +
        month +
        '#' +
        time.hour.toString() +
        '-' +
        (time.hour + 1).toString());
  }

  Future<void> sendResponseToDB(bool isCorrect, int timeElapsed) async {
    String roomCode = await getRoomCode();
    User user = await getUserData();
    await classroomCollection
        .doc(roomCode)
        .collection('responses')
        .doc(getTimeForResponses())
        .collection("allresponses")
        .doc(AuthService().getUID)
        .set({
      'Name': user.name,
      'PRN': user.prn,
      'Email': user.email,
      'answer': isCorrect,
      'time': timeElapsed,
    }, SetOptions(merge: true));
  }

  void saveIsAttempted(bool val) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isAttempted', val);
  }

  Future<bool?> getIsAttempted() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isAttempted');
  }
}
