import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:isbusiness/data/project/projects.dart';

abstract class ArchiveState extends Equatable {}

class InitialArchiveState extends ArchiveState {
  @override
  List<Object> get props => [];
}

class LoadingArchiveState extends ArchiveState {
  @override
  List<Object> get props => [];
}

class LoadingElementsArchiveState extends ArchiveState {
  @override
  List<Object> get props => [];
}

class LoadedArchiveState extends ArchiveState {
  String balls;
  String avatar;
  List<Event> projects;
  ScrollController scrollController;

  LoadedArchiveState(this.projects, this.scrollController, this.balls, this.avatar);

  @override
  List<Object> get props => [projects, scrollController, balls, avatar];
}

class ErrorArchiveState extends ArchiveState {
  @override
  List<Object> get props => [];
}