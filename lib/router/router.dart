import 'package:flutter/material.dart';
import 'package:isbusiness/screens/course/coursescreen.dart';
import 'package:isbusiness/screens/course/coursespromo.dart';
import 'package:isbusiness/screens/event/eventscreen.dart';
import 'package:isbusiness/screens/homemenu/menu.dart';
import 'package:isbusiness/screens/lesson/lessonscreen.dart';
import 'package:isbusiness/screens/library/libraryscreen.dart';
import 'package:isbusiness/screens/login/loginscreen.dart';
import 'package:isbusiness/screens/pastevent/pastevent.dart';
import 'package:isbusiness/screens/pastevents/pasteventsscreen.dart';
import 'package:isbusiness/screens/privilege/privilegescreen.dart';
import 'package:isbusiness/screens/profile/course.dart';
import 'package:isbusiness/screens/projectinfo/projectinfoscreen.dart';
import 'package:isbusiness/screens/registration/registrationscreen.dart';
import 'package:isbusiness/screens/settings/settings.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case registrationRoute:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case menuRoute:
        return MaterialPageRoute(builder: (_) => Menu());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case privilegeRoute:
        return MaterialPageRoute(builder: (_) => PrivilegeScreen());
      case projectInfoRoute:
        return MaterialPageRoute(builder: (_) => ProjectInfo());
      case courseInfoRoute:
        return MaterialPageRoute(builder: (_) => CourseInfo());
      case coursePromoRoute:
        return MaterialPageRoute(builder: (_) => CoursesPromo());
      case lessonInfoRoute:
        return MaterialPageRoute(builder: (_) => LessonInfo());
      case eventInfoRoute:
        return MaterialPageRoute(builder: (_) => EventInfo());
      case libraryRoute:
        return MaterialPageRoute(builder: (_) => LibraryScreen());
      case pastEventsRoute:
        return MaterialPageRoute(builder: (_) => PastEventsScreen());
      case pastEventRoute:
        return MaterialPageRoute(builder: (_) => EventPastInfo());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}

const loginRoute = '/login';
const registrationRoute = '/registration';
const menuRoute = '/menu';
const settingsRoute = '/settings';
const privilegeRoute = '/privilege';
const projectInfoRoute = '/projectInfo';
const courseInfoRoute = '/courseInfo';
const coursePromoRoute = '/coursePromo';
const lessonInfoRoute = '/lessonInfo';
const eventInfoRoute = '/eventInfo';
const libraryRoute = '/library';
const pastEventsRoute = '/pastevents';
const pastEventRoute = '/pastevent';