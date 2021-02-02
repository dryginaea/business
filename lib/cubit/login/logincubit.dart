import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:isbusiness/cubit/home/homecubit.dart';
import 'package:isbusiness/cubit/settings/settingscubit.dart';
import 'package:isbusiness/cubit/settings/settingsstate.dart';
import 'package:isbusiness/router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loginstate.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.apiService) : super(InitialState());

  ApiService apiService;

  void checkPhone(String phone, BuildContext context) async{
    emit(LoadingState());
    try {
      var response = await apiService.checkPhoneInDB(phone);
      print("message: " + response.message + ", status: " + response.status.toString());
      if(response.status) {
        emit(CheckPhoneInDBTrueState(phone));
      }

      if(!response.status) {
        Navigator.pushNamed(context, registrationRoute);
      }

    } catch (e) {
      emit(CheckPhoneInDBErrorState());
    }
  }

  void sendSMSCode(String phone) async{
    await apiService.sendSMS(phone).catchError((e) => CheckPhoneInDBErrorState());
  }

  void auth(String phone, String code, BuildContext context) async{
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
    ),));
    try {
      var response = await apiService.authUser(phone, code);
      if(response.status) {
        if(response.token != null) {
          apiService.saveToken(response.token);
          context.bloc<HomeCubit>().push();
          var push = await apiService.getStatusPush();
          context.bloc<SettingsCubit>().emit(LoadedSettingsState(push));
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(context, menuRoute, (Route<dynamic> route) => false);
        }
      } else {
        showDialog(context: context, builder: (_) => AlertDialog(
          content: Container(
            child: Text(
              response.message,
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 12,
              ),
            ),
          ),
          actions: [
            TextButton(
                child: Text(
                  'Назад',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontFamily: 'Segoe UI',
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
            )
          ],
        ));
      }
    } catch (e) {
      emit(AuthErrorState(e));
    }
  }
}