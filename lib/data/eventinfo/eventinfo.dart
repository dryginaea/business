class EventInfo {
  final String id;
  final String name;
  final String video;
  final String description;
  final String location;

  EventInfo(this.id, this.name, this.video, this.description, this.location);

  factory EventInfo.fromJson(Map<String, dynamic> json) {
    return EventInfo(json["id_project"], json["name"], json["video"].split('/').last, json["description"], json["location"]);
  }
}