import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/data/course/course.dart';
import 'package:isbusiness/data/product/product.dart';
import 'package:isbusiness/data/project/projects.dart';
import 'package:isbusiness/data/user/userdata.dart';

abstract class ProfileState extends Equatable {}

class InitialProfileState extends ProfileState {
  @override
  List<Object> get props => [];
}

class LoadingProfileState extends ProfileState {
  @override
  List<Object> get props => [];
}

class LoadedProfileState extends ProfileState {
  UserData user;
  String balls;
  Product tempProduct;
  Product nextProduct;
  List<Event> pastProject;
  List<Course> courses;
  String avatar;
  Map<String, bool> interests;
  bool push;

  LoadedProfileState(this.user, this.balls, this.tempProduct, this.nextProduct, this.pastProject, this.courses, this.avatar, this.interests, this.push);

  @override
  List<Object> get props => [user, balls, tempProduct, nextProduct, pastProject, courses, avatar, interests, push];
}

class ErrorProfileState extends ProfileState {
  @override
  List<Object> get props => [];
}