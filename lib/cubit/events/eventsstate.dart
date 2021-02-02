import 'package:equatable/equatable.dart';
import 'package:isbusiness/data/project/projects.dart';

abstract class EventsState extends Equatable {}

class InitialEventsState extends EventsState {
  @override
  List<Object> get props => [];
}

class LoadingEventsState extends EventsState {
  @override
  List<Object> get props => [];
}

class LoadedEventsState extends EventsState {
  List<Project> projects;
  String balls;
  String avatar;

  LoadedEventsState(this.projects, this.balls, this.avatar);

  @override
  List<Object> get props => [projects, balls, avatar];
}

class ErrorEventsState extends EventsState {
  @override
  List<Object> get props => [];
}