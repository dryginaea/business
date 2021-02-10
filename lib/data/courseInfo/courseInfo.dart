class CourseInfo {
  String video;
  String name;
  String htmlBody;
  int status_buy;

  CourseInfo(this.video, this.name, this.htmlBody, this.status_buy);

  factory CourseInfo.fromJson(Map<String, dynamic> json) {
    return CourseInfo(json["info"]["video"], json["info"]["name"], json["info"]["content"], json["status_buy"]);
  }
}