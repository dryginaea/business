class LessonInfo {
  String id;
  String id_course;
  String title;
  String content_buy;
  String content_not_buy;
  String blur;
  String image;

  LessonInfo(this.id, this.id_course, this.title, this.content_buy, this.content_not_buy, this.blur, this.image);

  factory LessonInfo.fromJson(Map<String, dynamic> json) {
    return LessonInfo(json["id"].toString(), json["id_course"].toString(), json["title"].toString(),
        json["content_buy"].toString(), json["content_not_buy"].toString(),
        json["blur"].toString(), json["image"].toString());
  }
}