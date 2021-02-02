class CourseInfo {
  String video;
  String name;
  String htmlBody;

  CourseInfo(this.video, this.name, this.htmlBody);

  factory CourseInfo.fromJson(Map<String, dynamic> json) {
    return CourseInfo(json["info"]["video"], json["info"]["name"], json["info"]["content"]);
  }
}