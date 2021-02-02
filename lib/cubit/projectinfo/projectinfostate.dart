import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:isbusiness/data/project/projects.dart';

abstract class ProjectInfoState extends Equatable {}

class InitialProjectInfoState extends ProjectInfoState {
  @override
  List<Object> get props => [];
}

class LoadingProjectInfoState extends ProjectInfoState {
  @override
  List<Object> get props => [];
}

class LoadedProjectInfoState extends ProjectInfoState {
  String id;
  String name;
  String video;
  String description;
  List<Event> events;
  String avatar;
  String balls;
  bool check;

  LoadedProjectInfoState(this.id, this.name, this.video, this.description, this.events, this.avatar, this.balls, this.check);

  @override
  List<Object> get props => [id, name, video, description, events, avatar, balls, check];
}

class ErrorProjectInfoState extends ProjectInfoState {
  @override
  List<Object> get props => [];
}