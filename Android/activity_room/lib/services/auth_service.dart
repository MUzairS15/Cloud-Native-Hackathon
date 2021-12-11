import 'package:activity_room/models/user.dart' as myuser;
import 'package:activity_room/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUserFromFireBase {
    return firebaseAuth.currentUser;
  }

  String get getUID {
    return firebaseAuth.currentUser!.uid;
  }

  Stream<User?> get onAuthStateChanged {
    return firebaseAuth.authStateChanges();
  }

  Future<void> googleSignout() async {
    GoogleSignIn().disconnect();
    await firebaseAuth.signOut();
  }

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.additionalUserInfo!.isNewUser) {
      myuser.User usr = DatabaseService().makeUserForDB(
          userCredential.user!.displayName.toString(),
          "sign in with google",
          userCredential.user!.email.toString());
      DatabaseService().addUserToDB(usr);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please add your PRN number in Profile tab")));
    }

    // Once signed in, return the UserCredential
    return userCredential;
  }

  Future<UserCredential?> signUpWithEmail(BuildContext context, String name,
      String prn, String email, String pass) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      myuser.User usr = DatabaseService().makeUserForDB(name, prn, email);
      DatabaseService().addUserToDB(usr);
      Navigator.pop(context);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return null;
  }

  // for login
  Future<void> signInWithEmail(
      BuildContext context, String email, String pass) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      // return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('Wrong password provided for that user.')));
      }
    }
  }
}
