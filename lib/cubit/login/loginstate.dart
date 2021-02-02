import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class InitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class CheckPhoneInDBTrueState extends LoginState {
  String phone;

  CheckPhoneInDBTrueState(this.phone);

  @override
  List<Object> get props => [phone];
}

class CheckPhoneInDBFalseState extends LoginState {
  @override
  List<Object> get props => [];
}

class CheckPhoneInDBErrorState extends LoginState {
  @override
  List<Object> get props => [];
}

class AuthErrorState extends LoginState {
  String error;

  AuthErrorState(this.error);

  @override
  List<Object> get props => [error];
}