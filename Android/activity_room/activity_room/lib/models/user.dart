class User {
  String? name;
  String? prn;
  String? email;
  String? uid;
  bool isAttendingClass;
  String? roomCode;
  String? roomSubject;
  bool isTeacher;
  Map<String, dynamic> scores;

  User(
      {required this.name,
      required this.prn,
      required this.email,
      required this.uid,
      this.roomCode = '',
      this.roomSubject = '',
      this.isAttendingClass = false,
      this.isTeacher = false,
      required this.scores});
}
