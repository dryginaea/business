import 'package:equatable/equatable.dart';
import 'package:isbusiness/data/privilege/privilege.dart';

abstract class PrivilegeState extends Equatable {}

class InitialPrivilegeState extends PrivilegeState {
  @override
  List<Object> get props => [];
}

class LoadingPrivilegeState extends PrivilegeState {
  @override
  List<Object> get props => [];
}

class LoadedPrivilegeState extends PrivilegeState {
  List<Privilege> privilege;

  LoadedPrivilegeState(this.privilege);

  @override
  List<Object> get props => [privilege];
}

class ErrorPrivilegeState extends PrivilegeState {
  @override
  List<Object> get props => [];
}