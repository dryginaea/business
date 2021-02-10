import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/api/Api.dart';

import 'archivestate.dart';

class ArchiveCubit extends Cubit<ArchiveState> {
  ArchiveCubit(this.apiService) : super(InitialArchiveState());

  ApiService apiService;

  void initial() async{
    emit(LoadingArchiveState());
    try {
      int i = 0;
      var projects = await apiService.getArchive(i);
      print(projects.myevents.length);
      var balls = await apiService.getBalls();
      var user = await apiService.getUserData();
      var checkAvatar = await apiService.checkUserAvatar();
      var avatar;
      if (checkAvatar) {
        var date = await apiService.getAvatar();
        avatar = 'https://inficomp.ru/anketa/api/avatars/${user.id}.jpg' + date;
      }

      ScrollController _scrollController = ScrollController();
      _scrollController.addListener(() async{
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          i = i + 9;
          var list = await apiService.getArchive(i);
          projects.myevents.addAll(list.myevents);
          emit(LoadingElementsArchiveState());
          emit(LoadedArchiveState(projects.myevents, _scrollController, balls, avatar));
        }
      });
      emit(LoadedArchiveState(projects.myevents, _scrollController, balls, avatar));
    } catch (e) {
      emit(ErrorArchiveState());
    }
  }
}