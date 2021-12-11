import 'package:activity_room/services/auth_service.dart';
import 'package:activity_room/views/pages/homepage.dart';
import 'package:activity_room/views/pages/login_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://mipmap/ic_launcher',
      [
        NotificationChannel(
            channelKey: 'key',
            channelName: 'activity_room',
            channelDescription: 'Send Notification',
            defaultColor: Colors.white,
            ledColor: Colors.blue,
            playSound: true,
            locked: false)
      ]);

  runApp(const MyApp());
}

// double currentTimeInSeconds() {
//   var ms = (DateTime.now()).millisecondsSinceEpoch;
//   return (ms / 1000);
// }
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Wrapper(),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: AuthService().onAuthStateChanged,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            return user == null ? LoginPage() : HomePage();
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            ));
          }
        });
  }
}
