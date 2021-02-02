import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {}

class InitialSettingsState extends SettingsState {
  @override
  List<Object> get props => [];
}

class LoadingSettingsState extends SettingsState {
  @override
  List<Object> get props => [];
}

class LoadedSettingsState extends SettingsState {
  bool push;

  LoadedSettingsState(this.push);

  @override
  List<Object> get props => [push];
}