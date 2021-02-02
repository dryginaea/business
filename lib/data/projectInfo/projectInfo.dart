class ProjectInfo {
  final String name;
  final String video;
  final String description;

  ProjectInfo(this.name, this.video, this.description);

  factory ProjectInfo.fromJson(Map<String, dynamic> json) {
    return ProjectInfo(json["name"], json["video"].split('/').last, json["description"]);
  }
}