import 'package:bloc/bloc.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'eventpastinfostate.dart';


class EventPastInfoCubit extends Cubit<EventPastInfoState> {
  EventPastInfoCubit(this.apiService) : super(InitialEventPastInfoState());

  ApiService apiService;

  void initial(String id, String date, String location) async{
    emit(LoadingEventPastInfoState());
    try {
      var info = await apiService.getEvent(id);
      emit(LoadedEventPastInfoState(info.name, date, info.description, info.location, info.video));
    } catch (e) {
      print(e);
      emit(ErrorEventPastInfoState());
    }
  }
}