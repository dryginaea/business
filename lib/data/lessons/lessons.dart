class Lesson {
  String id;
  String title;
  String content_buy;
  String content_not_buy;

  Lesson(this.id, this.title, this.content_buy, this.content_not_buy);
}

class Lessons {
  List<Lesson> lessons;

  Lessons(this.lessons);

  factory Lessons.fromJson(List<dynamic> json) {
    var list = List<Lesson>();
    for (var e in json) {
      list.insert(int.parse(e["sort"]) - 1, Lesson(e["id"].toString(), e["title"].toString(), e["content_buy"].toString(), e["content_not_buy"].toString()));
    }

    return Lessons(list);
  }
}