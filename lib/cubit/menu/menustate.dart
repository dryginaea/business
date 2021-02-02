import 'package:equatable/equatable.dart';

abstract class MenuState extends Equatable {}

class InitialMenuState extends MenuState {
  int current;

  InitialMenuState(this.current);

  @override
  List<Object> get props => [current];
}