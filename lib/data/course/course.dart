class Course {
  String id;
  String name;
  String image;

  Course(this.id, this.name, this.image);
}

class Courses {
  List<Course> courses;

  Courses(this.courses);

  factory Courses.fromJson(List<dynamic> json) {
    var list = List<Course>();
    list = json.map((course) {
      return Course(course["id"].toString(), course["name"].toString(), course["image"].toString());
    }).toList();
    return Courses(list);
  }
}