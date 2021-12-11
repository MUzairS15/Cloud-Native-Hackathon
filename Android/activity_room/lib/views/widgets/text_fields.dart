import 'package:activity_room/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailTextField extends AuthField {
  const EmailTextField(TextEditingController controller, Color textColor)
      : super(
            // onChanged: onChanged,
            text: 'Email Address',
            obscureText: false,
            validator: Validator.email,
            keyboardType: TextInputType.emailAddress,
            controller: controller,
            textColor: textColor);
}

class PasswordTextField extends AuthField {
  const PasswordTextField(TextEditingController controller, Color textColor)
      : super(
            // onChanged: onChanged,
            text: 'Password',
            obscureText: true,
            validator: Validator.password,
            controller: controller,
            textColor: textColor);
}

class NameTextField extends AuthField {
  const NameTextField(TextEditingController controller, Color textColor)
      : super(
            // onChanged: onChanged,
            text: 'Name',
            obscureText: false,
            validator: Validator.name,
            controller: controller,
            keyboardType: TextInputType.name,
            textColor: textColor);
}

class PRNTextField extends AuthField {
  const PRNTextField(TextEditingController controller, Color textColor)
      : super(
            // onChanged: onChanged,
            text: 'PRN',
            obscureText: false,
            validator: Validator.PRN,
            controller: controller,
            keyboardType: TextInputType.phone,
            textColor: textColor);
}

class AuthField extends StatelessWidget {
  // final void Function(String) onChanged;
  final String? text;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Color? textColor;
  const AuthField(
      {
      // this.onChanged,
      this.text,
      this.obscureText,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    // TextEditingController _controller;
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 5.0, left: 17.0, right: 17.0),
      child: AspectRatio(
        aspectRatio: 343 / 52,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText!,
            validator: validator,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              errorStyle: const TextStyle(color: Colors.blue),
              border: InputBorder.none,
              hintText: text,
              hintStyle: GoogleFonts.poppins(fontSize: 17, color: textColor),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ),
      ),
    );
  }
}
