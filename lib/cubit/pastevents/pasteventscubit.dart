import 'package:bloc/bloc.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:isbusiness/cubit/pastevents/pasteventsstate.dart';



class EventsPastCubit extends Cubit<EventsPastState> {
  EventsPastCubit(this.apiService) : super(InitialPastEventsState());

  ApiService apiService;

  void initial() async{
    emit(LoadingPastEventsState());
    try {
      var events = await apiService.getPastEvents();
      emit(LoadedPastEventsState(events.myevents));
    } catch (e) {
      emit(ErrorPastEventsState());
    }
  }
}