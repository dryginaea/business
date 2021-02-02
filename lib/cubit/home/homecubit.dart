import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:isbusiness/pushNotifications/pushNotifications.dart';
import 'package:platform_device_id/platform_device_id.dart';

import 'homestate.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.apiService) : super(InitialHomeState());

  ApiService apiService;

  void push() async{
    final token = await PushNotificationsManager().init();
    final deviceId = await PlatformDeviceId.getDeviceId;

    if (token != null) await apiService.updateFCMToken(token, deviceId);
  }

  void initial() async{
    emit(LoadingHomeState());
    try {
      var projects = await apiService.getProjects();
      var balls = await apiService.getBalls();
      var user = await apiService.getUserData();
      var courses = await apiService.getCourses([1, 2, 3, 4, 5, 6, 7, 8, 16, 17, 18, 19, 20, 21, 22, 23, 24], -1);
      var myProjects = await apiService.getMyEvents();
      var partnerProjects = await apiService.getPartnersEvents();
      var checkAvatar = await apiService.checkUserAvatar();
      var avatar;
      if (checkAvatar) {
        var date = await apiService.getAvatar();
        avatar = 'https://inficomp.ru/anketa/api/avatars/${user.id}.jpg' + date;
      }

      var endEvents = projects.projects.length < 5 ? projects.projects.length : 5;

      emit(LoadedHomeState(projects.projects.sublist(0, endEvents), balls, user.name, courses.courses, myProjects.myevents, partnerProjects.projects, avatar));
    } catch (e) {
      emit(ErrorHomeState());
    }
  }
}