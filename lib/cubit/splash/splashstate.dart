import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {}

class InitialState extends SplashState {
  @override
  List<Object> get props => [];
}

class LoadingState extends SplashState {
  @override
  List<Object> get props => [];
}
