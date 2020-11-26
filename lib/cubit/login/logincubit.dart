import 'package:bloc/bloc.dart';
import 'package:isbusiness/api/Api.dart';

import 'loginstate.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());

  void checkPhone(String phone) async{
    emit(LoadedState());
    try {
      var response = await checkPhoneInDB(phone);
      if(response.status) {
        emit(CheckPhoneInDBTrueState(phone));
      }

      if(!response.status) {
        emit(CheckPhoneInDBFalseState());
      }

    } catch (e) {
      emit(CheckPhoneInDBErrorState(e));
    }
  }

  void sendSMSCode(String phone) async{
    await sendSMS(phone).catchError((e) => CheckPhoneInDBErrorState(e));
  }

  void auth(String phone, String code) async{
    emit(LoadedState());
    try {
      var response = await authUser(phone, code);
      if(response.token != null) {
        emit(AuthTrueState(response.token));
      }
    } catch (e) {
      emit(AuthErrorState(e));
    }
  }
}