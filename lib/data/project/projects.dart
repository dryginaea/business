class Event {
  final String id;
  final String id_project;
  final String name;
  final String dateTime;
  final String dateDay;
  final String image;
  final String speakers;
  final String short_location;
  final String location;
  final bool isOnline;
  final String cost_balls;
  final String give_balls;
  
  Event(this.id, this.id_project, this.name, this.dateTime, this.dateDay, this.image, this.speakers, this.short_location, this.location, this.isOnline, this.cost_balls, this.give_balls);
}

class Events {
  final List<Event> myevents;

  Events({this.myevents});

  factory Events.fromJson(List<dynamic> json) {
    var list = List<Event>();

    for (var event in json) {
      var dateTime = event["date_time_start"].toString();
      var dateStartTime = dateTime.split(" ")[0].split('-')[2] + "." + dateTime.split(" ")[0].split('-')[1] + "." + dateTime.split(" ")[0].split('-')[0];
      dateTime = dateStartTime + " | " + dateTime.split(" ")[1];

      var date = event["date_time_start"].toString();
      if (date.split(" ")[0] == event["date_time_end"].toString().split(" ")[0]) {
        var dateStart = date.split(" ")[0].split('-')[2] + "." + date.split(" ")[0].split('-')[1] + "." + date.split(" ")[0].split('-')[0];
        date = dateStart + " | " + date.split(" ")[1] + " - " + event["date_time_end"].toString().split(" ")[1];
      }
      else {
        var dateStart = date.split(" ")[0].split('-')[2] + "." + date.split(" ")[0].split('-')[1] + "." + date.split(" ")[0].split('-')[0];
        var dateFinish = event["date_time_end"].toString().split(" ")[0].split('-')[2] + "." + event["date_time_end"].toString().split(" ")[0].split('-')[1] + "." + event["date_time_end"].toString().split(" ")[0].split('-')[0];
        date = dateStart + " - " + dateFinish;
      }

      list.add(Event(event["id"].toString(), event["id_project"].toString(), event["name"].toString(), dateTime, date, event["images"].toString().replaceAll(" ", ""), event["speakers"].toString(), event["short_location"].toString(), event["location"].toString(), event["is_online"], event["cost_balls"], event["give_balls"]));
    }

    return Events(myevents: list);
  }
}

class Project {
  final String id;
  final String name;
  final String image;
  final String dateTime;
  final List<Event> events;

  Project(this.id, this.name, this.image, this.dateTime, this.events);
}

class Projects {
  final List<Project> projects;

  Projects({this.projects});

  factory Projects.fromJson(List<dynamic> json) {
    var list = List<Project>();
    list = json.map((project) {
      var events = List<Event>();

      for (var event in project["events"]) {
        var dateTime = event["date_time_start"].toString();
        var dateStartTime = dateTime.split(" ")[0].split('-')[2] + "." + dateTime.split(" ")[0].split('-')[1] + "." + dateTime.split(" ")[0].split('-')[0];
        dateTime = dateStartTime + " | " + dateTime.split(" ")[1];

        var date = event["date_time_start"].toString();
        if (date.split(" ")[0] == event["date_time_end"].toString().split(" ")[0]) {
          var dateStart = date.split(" ")[0].split('-')[2] + "." + date.split(" ")[0].split('-')[1] + "." + date.split(" ")[0].split('-')[0];
          date = dateStart + " | " + date.split(" ")[1] + " - " + event["date_time_end"].toString().split(" ")[1];
        }
        else {
          var dateStart = date.split(" ")[0].split('-')[2] + "." + date.split(" ")[0].split('-')[1] + "." + date.split(" ")[0].split('-')[0];
          var dateFinish = event["date_time_end"].toString().split(" ")[0].split('-')[2] + "." + event["date_time_end"].toString().split(" ")[0].split('-')[1] + "." + event["date_time_end"].toString().split(" ")[0].split('-')[0];
          date = dateStart + " - " + dateFinish;
        }

        events.add(Event(event["id"].toString(), event["id_project"].toString(), event["name"].toString(), dateTime, date, event["images"].toString().replaceAll(" ", ""), event["speakers"].toString(), event["short_location"].toString(), event["location"].toString(), event["is_online"], event["cost_balls"], event["give_balls"]));
      }

      var date = project["date_time_start"].toString();
      if (date.split(" ")[0] == project["date_time_end"].toString().split(" ")[0]) {
        var dateStart = date.split(" ")[0].split('-')[2] + "." + date.split(" ")[0].split('-')[1] + "." + date.split(" ")[0].split('-')[0];
        date = dateStart + " | " + date.split(" ")[1] + " - " + project["date_time_end"].toString().split(" ")[1];
      }
      else {
        var dateStart = date.split(" ")[0].split('-')[2] + "." + date.split(" ")[0].split('-')[1] + "." + date.split(" ")[0].split('-')[0];
        var dateFinish = project["date_time_end"].toString().split(" ")[0].split('-')[2] + "." + project["date_time_end"].toString().split(" ")[0].split('-')[1] + "." + project["date_time_end"].toString().split(" ")[0].split('-')[0];
        date = dateStart + " - " + dateFinish;
      }

      return Project(project["id"].toString(), project["name"].toString(), project["images"].toString().replaceAll(" ", ""), date, events);
    }).toList();

    return Projects(
        projects: list
    );
  }
}