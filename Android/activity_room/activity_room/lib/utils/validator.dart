// ignore_for_file: non_constant_identifier_names

class Validator {
  // ignore: constant_identifier_names
  static const String EMAIL_REGEX =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static String? email(String? email) {
    if (email == null) return 'Email cannot be empty';
    if (email.length < 5) {
      return 'Email must be at least 5 characters long';
    }

    if (!RegExp(EMAIL_REGEX).hasMatch(email)) {
      return 'Email must be in the right format';
    }

    return null;
  }

  static String? password(String? password) {
    if (password == null) return 'Password cannot be empty';
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  static String? name(String? uname) {
    if (uname == null) {
      return 'Name cannot be null';
    }
    if (uname.isEmpty) {
      return 'Name cannot be null';
    }

    return null;
  }

  static String? PRN(String? PRN) {
    if (PRN == null) return 'PRN number cannot be empty';
    if (PRN.length != 8) {
      return 'PRN number must be 8 digit number';
    }

    return null;
  }
}
