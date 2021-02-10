import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/api/Api.dart';

import 'profilestate.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.apiService) : super(InitialProfileState());

  ApiService apiService;

  void initial() async{
    emit(LoadingProfileState());
    try {
      var user = await apiService.getUserData();
      var interests = await apiService.getInterests();
      var balls = await apiService.getBalls();
      var products = await apiService.getProducts();
      var nextProduct = products.products.firstWhere((element) => (int.parse(element.cost_balls) > int.parse(balls)), orElse: () => products.products.last);
      var tempProduct = products.products.first;
      if (products.products.indexOf(nextProduct) - 1 < 0) {
        nextProduct = products.products[1];
      } else tempProduct = products.products[products.products.indexOf(nextProduct) - 1];
      var pastEvents = await apiService.getPastEvents();
      var courses = await apiService.getMyCourses();
      var myProjects = await apiService.getMyEvents();
      var checkAvatar = await apiService.checkUserAvatar();
      var push = await apiService.getStatusPush();
      var avatar;
      if (checkAvatar) {
        var date = await apiService.getAvatar();
        avatar = 'https://inficomp.ru/anketa/api/avatars/${user.id}.jpg' + date;
      }

      var endPastEvents = pastEvents.myevents.length < 3 ? pastEvents.myevents.length : 3;

      emit(LoadedProfileState(user, balls, tempProduct, nextProduct, pastEvents.myevents.sublist(0, endPastEvents), courses.courses, myProjects.myevents, avatar, interests.interests, push));
    } catch (e) {
      emit(ErrorProfileState());
    }
  }

  void showEditError(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      content: Text(
        "Произошла ошибка при отправке данных на сервер. Повторите попытку.",
        style: TextStyle(
          fontFamily: 'Segoe UI',
          fontSize: 12,
        ),
      ),
      actions: [
        TextButton(child: Text(
          'Ок',
          style: TextStyle(
            color: Colors.blueAccent,
            fontFamily: 'Segoe UI',
            fontSize: 14,
          ),
        ),
          onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
          },
        )
      ],
    ));
  }
}