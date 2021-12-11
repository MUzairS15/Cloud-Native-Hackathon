import 'package:activity_room/consts/consts.dart';
import 'package:activity_room/services/auth_service.dart';
import 'package:activity_room/services/database_service.dart';
import 'package:activity_room/views/pages/qr_scan_page.dart';
import 'package:activity_room/views/widgets/profile_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageView extends StatelessWidget {
  HomePageView({Key? key}) : super(key: key);
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('users');
  final TextEditingController _codeControlller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().homepagecolor,
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          FutureBuilder<DocumentSnapshot>(
              future: userDataCollection.doc(AuthService().getUID).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return ProfileContainer(
                    data: data,
                  );
                }
                return const ProfileContainer(
                  data: {"Name": "USER111", "Email": "USER111@gmail.com"},
                );
              }),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 70,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 22.0, top: 22, right: 18),
                  child: Text("Enter Room Code",
                      style: GoogleFonts.lato(
                          fontSize: 25,
                          color: MyColors().homepagecolor,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, top: 18, right: 18),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors().homepagecolor),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.transparent,
                    ),
                    child: TextField(
                      controller: _codeControlller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorStyle: const TextStyle(
                            color: Color(0xFF58D2C3), fontSize: 13),
                        hintText: 'Code',
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 17, color: MyColors().homepagecolor),
                        contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_codeControlller.text.length == 6) {
                        DatabaseService()
                            .addRoomCodeToDB(_codeControlller.text);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: MyColors().homepagecolor,
                            duration: const Duration(seconds: 2),
                            content: const Text("Enter a valid Code!")));
                      }
                    },
                    child: const Text(
                      'Join Room',
                      style: TextStyle(fontSize: 17),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(135, 35),
                        primary: MyColors().homepagecolor),
                  ),
                )),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text("OR",
                      style: GoogleFonts.lato(
                          fontSize: 25,
                          color: MyColors().homepagecolor,
                          fontWeight: FontWeight.bold)),
                )),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const QRViewPage())),
                    child: const Text('Scan QR Code',
                        style: TextStyle(fontSize: 17)),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(120, 35),
                        primary: MyColors().homepagecolor),
                  ),
                ))
              ],
            ),
          )
        ],
      )),
    );
  }
}
