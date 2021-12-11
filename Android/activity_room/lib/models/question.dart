class Question {
  String? id;
  String? type;
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? answer;
  int score;

  Question({
    required this.id,
    required this.type,
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.answer,
    required this.score,
  });

  factory Question.fromSnapshot(Map data) {
    return Question(
        id: data['id'],
        type: data['type'],
        question: data['question'],
        option1: data['option1'],
        option2: data['option2'],
        option3: data['option3'],
        option4: data['option4'],
        answer: data['answer'],
        score: data['score']);
  }
}
