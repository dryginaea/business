import 'package:equatable/equatable.dart';
import 'package:isbusiness/data/course/course.dart';
import 'package:isbusiness/data/partnerproject/partnerproject.dart';
import 'package:isbusiness/data/project/projects.dart';

abstract class HomeState extends Equatable {}

class InitialHomeState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadingHomeState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadedHomeState extends HomeState {
  List<Project> projects;
  String balls;
  String name;
  List<Course> courses;
  List<Event> myProjects;
  List<PartnerProject> partnerProjects;
  String avatar;

  LoadedHomeState(this.projects, this.balls, this.name, this.courses, this.myProjects, this.partnerProjects, this.avatar);

  @override
  List<Object> get props => [projects, balls, name, courses, myProjects, partnerProjects, avatar];
}

class ErrorHomeState extends HomeState {
  @override
  List<Object> get props => [];
}