class User {
  String? name;
  String? prn;
  String? email;
  String? uid;
  bool isAttendingClass;
  String? roomCode;
  bool isTeacher;
  int score;

  User(
      {required this.name,
      required this.prn,
      required this.email,
      required this.uid,
      this.roomCode = '',
      this.isAttendingClass = false,
      this.isTeacher = false,
      this.score = 0});
}
