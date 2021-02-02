import 'package:equatable/equatable.dart';
import 'package:isbusiness/data/lessoninfo/lessoninfo.dart';
import 'package:isbusiness/data/lessons/lessons.dart';
import 'package:isbusiness/data/questions/questions.dart';
import 'package:isbusiness/data/user/userdata.dart';

abstract class LessonInfoState extends Equatable {}

class InitialLessonInfoState extends LessonInfoState {
  @override
  List<Object> get props => [];
}

class LoadingLessonInfoState extends LessonInfoState {
  @override
  List<Object> get props => [];
}

class LoadedLessonInfoState extends LessonInfoState {
  String id;
  LessonInfo lesson;
  UserData user;
  String avatar;
  String balls;
  bool check;
  List<Question> questions;
  List<Lesson> lessons;
  int index;

  LoadedLessonInfoState(this.id, this.lesson, this.user, this.avatar, this.balls, this.check, this.questions, this.lessons, this.index);

  @override
  List<Object> get props => [id, lesson, user, avatar, balls, check, questions, lessons, index];
}

class ErrorLessonInfoState extends LessonInfoState {
  @override
  List<Object> get props => [];
}