import 'package:bloc/bloc.dart';
import 'package:isbusiness/api/Api.dart';

import 'coursespromostate.dart';


class CoursesPromoCubit extends Cubit<CoursesPromoState> {
  CoursesPromoCubit(this.apiService) : super(InitialCoursesPromoState());

  ApiService apiService;

  void initial(String promo, String balls, String avatar) async{
    emit(LoadingCoursesPromoState());
    try {
      var courses = await apiService.getCoursesPromocode(promo);
      emit(LoadedCoursesPromoState(balls, avatar, courses.courses));
    } catch (e) {
      emit(ErrorCoursesPromoState());
    }
  }
}