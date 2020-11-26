import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class LoadedState extends LoginState {
  @override
  List<Object> get props => [];
}

class InitialState extends LoginState {
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
  String error;

  CheckPhoneInDBErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class AuthTrueState extends LoginState {
  String token;

  AuthTrueState(this.token);

  @override
  List<Object> get props => [token];
}

class AuthErrorState extends LoginState {
  String error;

  AuthErrorState(this.error);

  @override
  List<Object> get props => [error];
}