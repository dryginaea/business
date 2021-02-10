import 'package:equatable/equatable.dart';
import 'package:isbusiness/data/lessons/lessons.dart';
import 'package:isbusiness/data/questions/questions.dart';
import 'package:isbusiness/data/rates/rates.dart';
import 'package:isbusiness/data/user/userdata.dart';

abstract class CourseInfoState extends Equatable {}

class InitialCourseInfoState extends CourseInfoState {
  @override
  List<Object> get props => [];
}

class LoadingCourseInfoState extends CourseInfoState {
  @override
  List<Object> get props => [];
}

class LoadedCourseInfoState extends CourseInfoState {
  String id;
  UserData user;
  String name;
  String video;
  String htmlBody;
  String avatar;
  String balls;
  int check;
  List<Lesson> lessons;
  List<Question> questions;
  List<Rate> rates;

  LoadedCourseInfoState(this.id, this.user, this.name, this.video, this.htmlBody, this.avatar, this.balls, this.check, this.lessons, this.questions, this.rates);

  @override
  List<Object> get props => [id, user, name, video, htmlBody, avatar, balls, check, lessons, questions, rates];
}

class ErrorCourseInfoState extends CourseInfoState {
  @override
  List<Object> get props => [];
}