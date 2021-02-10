import 'package:bloc/bloc.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:flutter/material.dart';

import 'coursespromostate.dart';


class CoursesPromoCubit extends Cubit<CoursesPromoState> {
  CoursesPromoCubit(this.apiService) : super(InitialCoursesPromoState());

  ApiService apiService;

  void initial(BuildContext context, String promo, String balls, String avatar) async{
    emit(LoadingCoursesPromoState());
    try {
      var courses = await apiService.getCoursesPromocode(promo);
      if (courses.courses.length == 0) {
        Navigator.pop(context);
        showDialog(context: context, builder: (context) => AlertDialog(
          content: Text(
            'Промокод не действителен',
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Назад',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 14,
                    color: Colors.blueAccent
                  ),
                ),
            )
          ],
        ));
      }
      emit(LoadedCoursesPromoState(balls, avatar, courses.courses));
    } catch (e) {
      emit(ErrorCoursesPromoState());
    }
  }
}