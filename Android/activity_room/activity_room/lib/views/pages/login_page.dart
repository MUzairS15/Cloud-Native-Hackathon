// ignore_for_file: avoid_print

import 'package:activity_room/consts/consts.dart';
import 'package:activity_room/services/auth_service.dart';
import 'package:activity_room/utils/validator.dart';
import 'package:activity_room/views/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: MyColors().loginDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.15),
              Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, right: 18.0, bottom: 30.0),
                child: Text(
                  "Activity Room",
                  style: GoogleFonts.patuaOne(
                    fontSize: 45,
                    color: Colors.white,
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
                      child: AspectRatio(
                        aspectRatio: 343 / 52,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: _emailController,
                            obscureText: false,
                            validator: Validator.email,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                  color: Colors.white, fontSize: 13),
                              border: InputBorder.none,
                              hintText: 'Email Address',
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 17, color: Colors.white),
                              contentPadding: const EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 5.0, left: 20.0, right: 20.0),
                      child: AspectRatio(
                        aspectRatio: 343 / 52,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent,
                          ),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: _passwordController,
                            obscureText: true,
                            validator: Validator.password,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(color: Colors.white),
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 17, color: Colors.white),
                              contentPadding: const EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 5.0, left: 20.0, right: 20.0),
                child: AspectRatio(
                  aspectRatio: 343 / 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      minimumSize: Size(width * 0.6, height * 0.08),
                    ),
                    child: Text(
                      "Log In",
                      style: GoogleFonts.poppins(
                          color: MyColors().homepagecolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 19),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        AuthService().signInWithEmail(context,
                            _emailController.text, _passwordController.text);
                        print("Signing in...");
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 5.0, left: 20.0, right: 20.0),
                child: AspectRatio(
                  aspectRatio: 343 / 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      minimumSize: Size(width * 0.6, height * 0.08),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: SignInButton(
                        Buttons.Google,
                        elevation: 0.0,
                        onPressed: () async {
                          print('Google Sign in pressed');
                          try {
                            await AuthService().signInWithGoogle(context);
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: GestureDetector(
                  child: Text(
                    "Don't have an account? Sign Up",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                  ),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterPage())),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
