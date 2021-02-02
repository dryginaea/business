class Question {
  String question;
  String answer;
  String id_user;
  String name;

  Question(this.question, this.answer, this.id_user, this.name);
}

class Questions {
  List<Question> questions;

  Questions(this.questions);

  factory Questions.fromJson(List<dynamic> json) {
    var list = List<Question>();
    list = json.map((e) {
      return Question(e["question"].toString(), e["answer"].toString(), e["id_user"].toString(), e["name"].toString());
    }).toList();

    return Questions(list);
  }
}