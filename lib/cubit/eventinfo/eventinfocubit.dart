import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:isbusiness/cubit/home/homecubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'eventinfostate.dart';


class EventInfoCubit extends Cubit<EventInfoState> {
  EventInfoCubit(this.apiService) : super(InitialEventInfoState());

  ApiService apiService;

  void initial(String id, String date, String location, String avatar, String balls) async{
    emit(LoadingEventInfoState());
    try {
      var info = await apiService.getEvent(id);
      var check = await apiService.checkProject(info.id);
      emit(LoadedEventInfoState(info.id, info.name, date, info.description, location, info.video, avatar, balls, check));
    } catch (e) {
      print(e);
      emit(ErrorEventInfoState());
    }
  }

  void registration(BuildContext context, String id, String name, String date, String description, String location, String video, String avatar, String balls) async{
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
    ),));
    var message = await apiService.registrationProject(id);
    var check = await apiService.checkProject(id);
    emit(LoadedEventInfoState(id, name, date, description, location, video, avatar, balls, check));
    context.bloc<HomeCubit>().initial();
    Navigator.pop(context);
    showDialog(context: context, builder: (context) => AlertDialog(
      content: Text(
        message,
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
          },
        )
      ],
    ));
  }

  void registrationCancel(BuildContext context, String id, String name, String date, String description, String location, String video, String avatar, String balls) async{
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
    ),));
    var cancel = await apiService.cancelProject(id);
    var check = await apiService.checkProject(id);
    emit(LoadedEventInfoState(id, name, date, description, location, video, avatar, balls, check));
    context.bloc<HomeCubit>().initial();
    Navigator.pop(context);
    if (!cancel) showDialog(context: context, builder: (context) => AlertDialog(
      content: Text(
        "Произошла ошибка. Повторите действие.",
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
          },
        )
      ],
    ));
  }
}