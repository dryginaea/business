import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/home/homecubit.dart';
import 'package:isbusiness/cubit/settings/settingscubit.dart';
import 'package:isbusiness/cubit/settings/settingsstate.dart';
import 'package:isbusiness/router/router.dart';
import 'package:isbusiness/screens/registration/code.dart';

import 'registrationstate.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this.apiService) : super(InitialState());

  ApiService apiService;

  Future<void> send(Map<String, dynamic> interview, BuildContext context, String phone) async{
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
    ),));

    try {
      var response = await apiService.sendInterview(interview);
      if(response.status) {
        await apiService.sendSMS(phone);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => CodeRegistration(phone, response.token)));
      }

      if(!response.status) {
        Navigator.pop(context);
        emit(InitialState());
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                response.message,
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
              ),
              actions: [
                FlatButton(
                  child: Text(
                    "Назад",
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      color: Colors.blueAccent,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
        );
      }

    } catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Ошибка сети",
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 14,
              ),
              textAlign: TextAlign.left,
            ),
            actions: [
              FlatButton(
                child: Text(
                  "Ок",
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    color: Colors.blueAccent,
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
      );
    }
  }

  void checkSMSCode(String phone, BuildContext context, String code, String token) async{
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
    ),));
    try {
      var response = await apiService.checkSMS(phone, code, token);
      if (response.status) {
        await apiService.saveToken(token);
        context.bloc<HomeCubit>().push();
        var push = await apiService.getStatusPush();
        context.bloc<SettingsCubit>().emit(LoadedSettingsState(push));
        Navigator.pushNamedAndRemoveUntil(context, menuRoute, (Route<dynamic> route) => false);
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                response.message,
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
              ),
              actions: [
                FlatButton(
                  child: Text(
                    "Назад",
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      color: Colors.blueAccent,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
        );
      }
    } catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Ошибка сети",
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 14,
              ),
              textAlign: TextAlign.left,
            ),
            actions: [
              FlatButton(
                child: Text(
                  "Назад",
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    color: Colors.blueAccent,
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
      );
    }
  }

  void refreshCode(String phone, BuildContext context) async{
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
    ),));
    await apiService.sendSMS(phone);
    Navigator.pop(context);
  }
}