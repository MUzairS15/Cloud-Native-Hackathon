import 'package:activity_room/services/auth_service.dart';
import 'package:activity_room/views/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xFF0575e6), Color(0xFF00f260)])),
          ),
          title: Text(
            'Register',
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 28),
          ),
          leading: const BackButton(),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      NameTextField(_usernameController, Colors.grey.shade600),
                      PRNTextField(_phoneController, Colors.grey.shade600),
                      EmailTextField(_emailController, Colors.grey.shade600),
                      PasswordTextField(
                          _passwordController, Colors.grey.shade600),
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
                        "Register",
                        style: GoogleFonts.poppins(
                            color: Color(0xFF4180F5),
                            fontWeight: FontWeight.w500,
                            fontSize: 19),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await AuthService().signUpWithEmail(
                            context,
                            _usernameController.text,
                            _phoneController.text,
                            _emailController.text,
                            _passwordController.text,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
