import 'package:bloc/bloc.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:isbusiness/cubit/settings/settingsstate.dart';


class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.apiService) : super(InitialSettingsState());

  ApiService apiService;

  void initial() async{
    emit(LoadingSettingsState());
    try {
      var push = await apiService.getStatusPush();
      emit(LoadedSettingsState(push));
    } catch (e) {
      emit(LoadingSettingsState());
    }
  }

  void setPush(bool value) async{
    emit(LoadedSettingsState(value));
    await apiService.setStatusPush(value);
  }
}