import 'package:equatable/equatable.dart';
import 'package:isbusiness/data/project/projects.dart';

abstract class EventInfoState extends Equatable {}

class InitialEventInfoState extends EventInfoState {
  @override
  List<Object> get props => [];
}

class LoadingEventInfoState extends EventInfoState {
  @override
  List<Object> get props => [];
}

class LoadedEventInfoState extends EventInfoState {
  String id;
  String name;
  String date;
  String description;
  String short_location;
  String video;
  String avatar;
  String balls;
  bool check;

  LoadedEventInfoState(this.id, this.name, this.date, this.description, this.short_location, this.video, this.avatar, this.balls, this.check);

  @override
  List<Object> get props => [id, name, date, description, short_location, video, avatar, balls, check];
}

class ErrorEventInfoState extends EventInfoState {
  @override
  List<Object> get props => [];
}