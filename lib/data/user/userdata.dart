class UserData {
  String id;
  String name;
  String last_name;
  String surname;
  String type;
  String email;
  String phone;

  UserData(this.id, this.name, this.last_name, this.surname, this.type, this.email, this.phone);

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(json["id"].toString(), json["name"].toString(), json["last_name"].toString(), json["surname"].toString(), json["id_type"].toString(), json["email"].toString(), json["phone"].toString());
  }
}