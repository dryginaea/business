class PartnerProject {
  final String id;
  final String name;
  final String image;
  final String url;

  PartnerProject(this.id, this.name, this.image, this.url);
}

class PartnerProjects {
  final List<PartnerProject> projects;

  PartnerProjects({this.projects});

  factory PartnerProjects.fromJson(List<dynamic> json) {
    var list = List<PartnerProject>();
    list = json.map((project) {
      return PartnerProject(project["id"].toString(), project["name"].toString(), project["image"].toString(), project["url"].toString());
    }).toList();

    return PartnerProjects(
        projects: list
    );
  }
}