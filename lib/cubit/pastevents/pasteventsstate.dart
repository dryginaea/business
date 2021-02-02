import 'package:equatable/equatable.dart';
import 'package:isbusiness/data/project/projects.dart';

abstract class EventsPastState extends Equatable {}

class InitialPastEventsState extends EventsPastState {
  @override
  List<Object> get props => [];
}

class LoadingPastEventsState extends EventsPastState {
  @override
  List<Object> get props => [];
}

class LoadedPastEventsState extends EventsPastState {
  List<Event> events;

  LoadedPastEventsState(this.events);

  @override
  List<Object> get props => [events];
}

class ErrorPastEventsState extends EventsPastState {
  @override
  List<Object> get props => [];
}