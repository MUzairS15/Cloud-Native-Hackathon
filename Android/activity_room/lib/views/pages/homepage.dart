import 'package:activity_room/services/auth_service.dart';
import 'package:activity_room/views/pages/home_page_view.dart';
import 'package:activity_room/views/pages/room_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final Stream documentStream = FirebaseFirestore.instance
      .collection('users')
      .doc(AuthService().getUID)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
        stream: documentStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("An error occured!"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            var data = snapshot.data as DocumentSnapshot;
            if (data['isAttendingClass']) {
              return RoomPage(
                snapshot: snapshot,
              );
            } else {
              return HomePageView();
            }
          }
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        });
  }
}
