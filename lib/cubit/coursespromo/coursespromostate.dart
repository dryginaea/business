import 'package:equatable/equatable.dart';
import 'package:isbusiness/data/course/course.dart';

abstract class CoursesPromoState extends Equatable {}

class InitialCoursesPromoState extends CoursesPromoState {
  @override
  List<Object> get props => [];
}

class LoadingCoursesPromoState extends CoursesPromoState {
  @override
  List<Object> get props => [];
}

class LoadedCoursesPromoState extends CoursesPromoState {
  String balls;
  String avatar;
  List<Course> courses;

  LoadedCoursesPromoState(this.balls, this.avatar, this.courses);

  @override
  List<Object> get props => [balls, avatar, courses];
}

class ErrorCoursesPromoState extends CoursesPromoState {
  @override
  List<Object> get props => [];
}