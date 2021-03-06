import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:isbusiness/cubit/home/homecubit.dart';
import 'package:isbusiness/cubit/profile/profilecubit.dart';
import 'package:isbusiness/cubit/projectinfo/projectinfostate.dart';
import 'package:isbusiness/data/project/projects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProjectInfoCubit extends Cubit<ProjectInfoState> {
  ProjectInfoCubit(this.apiService) : super(InitialProjectInfoState());

  ApiService apiService;

  void initial(String id, List<Event> events, String avatar, String balls) async{
    emit(LoadingProjectInfoState());
    try {
      var info = await apiService.getProject(id);
      var check = await apiService.checkProject(id);
      emit(LoadedProjectInfoState(id, info.name, info.video, info.description, events, avatar, balls, check));
    } catch (e) {
      print(e);
      emit(ErrorProjectInfoState());
    }
  }

  void registration(BuildContext context, String id, String name, String video, String description, List<Event> events, String avatar, String balls) async{
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
    ),));
    var message = await apiService.registrationProject(id);
    var check = await apiService.checkProject(id);
    emit(LoadedProjectInfoState(id, name, video, description, events, avatar, balls, check));
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

  void registrationCancel(BuildContext context, String id, String name, String video, String description, List<Event> events, String avatar, String balls) async{
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
    ),));
    var cancel = await apiService.cancelProject(id);
    var check = await apiService.checkProject(id);
    emit(LoadedProjectInfoState(id, name, video, description, events, avatar, balls, check));
    context.bloc<HomeCubit>().initial();
    context.bloc<ProfileCubit>().initial();
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