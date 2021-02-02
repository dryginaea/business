import 'package:equatable/equatable.dart';

abstract class EventPastInfoState extends Equatable {}

class InitialEventPastInfoState extends EventPastInfoState {
  @override
  List<Object> get props => [];
}

class LoadingEventPastInfoState extends EventPastInfoState {
  @override
  List<Object> get props => [];
}

class LoadedEventPastInfoState extends EventPastInfoState {
  String name;
  String date;
  String description;
  String short_location;
  String video;

  LoadedEventPastInfoState(this.name, this.date, this.description, this.short_location, this.video);

  @override
  List<Object> get props => [name, date, description, short_location, video];
}

class ErrorEventPastInfoState extends EventPastInfoState {
  @override
  List<Object> get props => [];
}