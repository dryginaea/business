class Privilege {
  final String id;
  final String name;
  final String short_description;
  final String description;
  final String image;
  final String email;
  final bool is_registered;

  Privilege(this.id, this.name, this.short_description, this.description, this.image, this.email, this.is_registered);
}

class PrivilegeList {
  final List<Privilege> privilegelist;

  PrivilegeList(this.privilegelist);

  factory PrivilegeList.fromJson(List<dynamic> json) {
    var list = List<Privilege>();
    list = json.map((privilege) {
      return Privilege(privilege["id"].toString(), privilege["name"].toString(), privilege["short_description"].toString(), privilege["description"].toString(), privilege["image"].toString(), privilege["email"].toString(), privilege["is_registered"]);
    }).toList();

    return PrivilegeList(list);
  }
}