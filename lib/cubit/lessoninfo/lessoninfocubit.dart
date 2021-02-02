import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:isbusiness/data/lessons/lessons.dart';
import 'package:isbusiness/data/questions/questions.dart';
import 'package:isbusiness/data/user/userdata.dart';

import 'lessoninfostate.dart';

class LessonInfoCubit extends Cubit<LessonInfoState> {
  LessonInfoCubit(this.apiService) : super(InitialLessonInfoState());

  ApiService apiService;

  void initial(String id, UserData user, String avatar, String balls, bool check, List<Question> questions, List<Lesson> lessons, int index) async {
    emit(LoadingLessonInfoState());
    try {
      var lesson = await apiService.getLessonInfo(id);
      emit(LoadedLessonInfoState(id, lesson, user, avatar, balls, check, questions, lessons, index));
    } catch (e) {
      print(e);
      emit(ErrorLessonInfoState());
    }
  }
}