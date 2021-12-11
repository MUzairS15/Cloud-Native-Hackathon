// ignore_for_file: avoid_print

import 'package:activity_room/models/user.dart';
import 'package:activity_room/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('users');
  final String uid = AuthService().getUID;

  User makeUserForDB(String name, String prn, String email) {
    return User(name: name, prn: prn, email: email, uid: uid);
  }

  Future<void> addUserToDB(User user) async {
    userDataCollection.doc(uid).set({
      'Name': user.name,
      'PRN': user.prn,
      'Email': user.email,
      'UID': user.uid,
      'isAttendingClass': user.isAttendingClass,
      'isTeacher': user.isTeacher,
      'roomCode': user.roomCode,
      'score': user.score
    });
  }

  // join the room using code entered by the user
  Future<void> addRoomCodeToDB(String? code) async {
    try {
      userDataCollection
          .doc(uid)
          .update({'isAttendingClass': true, 'roomCode': code});
    } catch (e) {
      print(e);
    }
  }

  Future<void> leaveRoom() async {
    try {
      userDataCollection.doc(uid).update({
        'isAttendingClass': false,
      });
    } catch (e) {
      print(e);
    }
  }
}
