import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {}

class InitialState extends RegistrationState {
  @override
  List<Object> get props => [];
}

class LoadingState extends RegistrationState {
  @override
  List<Object> get props => [];
}

class YesState extends RegistrationState {
  @override
  List<Object> get props => [];
}

class YesAgreeState extends RegistrationState {
  @override
  List<Object> get props => [];
}

class NoState extends RegistrationState {
  int typePerson;

  NoState(this.typePerson);

  @override
  List<Object> get props => [typePerson];
}

class NoAgreeState extends RegistrationState {
  int typePerson;

  NoAgreeState(this.typePerson);

  @override
  List<Object> get props => [typePerson];
}

class ErrorState extends RegistrationState {
  int typePerson;
  bool yes;
  bool agree;
  bool typeNull;
  bool innNull;
  bool fioNull;
  bool dateNull;
  bool phoneNull;
  bool emailNull;
  bool phoneUncorrect;
  bool emailUncorrect;

  ErrorState(this.typePerson, this.yes, this.agree, this.typeNull, this.innNull, this.fioNull, this.dateNull, this.phoneNull, this.emailNull, this.phoneUncorrect, this.emailUncorrect);

  @override
  List<Object> get props => [typePerson, yes, agree, typeNull, innNull, fioNull, dateNull, phoneNull, emailNull, phoneUncorrect, emailUncorrect];
}