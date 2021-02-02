import 'package:bloc/bloc.dart';
import 'package:isbusiness/api/Api.dart';

import 'eventsstate.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit(this.apiService) : super(InitialEventsState());

  ApiService apiService;

  void initial() async{
    emit(LoadingEventsState());
    try {
      var projects = await apiService.getProjects();
      var balls = await apiService.getBalls();
      var user = await apiService.getUserData();
      var checkAvatar = await apiService.checkUserAvatar();
      var avatar;
      if (checkAvatar) {
        var date = await apiService.getAvatar();
        avatar = 'https://inficomp.ru/anketa/api/avatars/${user.id}.jpg' + date;
      }
      emit(LoadedEventsState(projects.projects, balls, avatar));
    } catch (e) {
      emit(ErrorEventsState());
    }
  }
}