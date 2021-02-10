import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:isbusiness/cubit/courseinfo/courseinfostate.dart';

class CourseInfoCubit extends Cubit<CourseInfoState> {
  CourseInfoCubit(this.apiService) : super(InitialCourseInfoState());

  ApiService apiService;

  void initial(String id, String avatar, String balls) async {
    emit(LoadingCourseInfoState());
    try {
      var user = await apiService.getUserData();
      var info = await apiService.getCourse(id);
      print("STATUS " + info.status_buy.toString());
      var lessons = await apiService.getCourseLessons(id);
      var questions = await apiService.getCourseQuestions(id);
      var rates = await apiService.getCourseRates(id);
      emit(LoadedCourseInfoState(id, user, info.name, info.video, info.htmlBody, avatar, balls, info.status_buy, lessons.lessons, questions.questions, rates.rates));
    } catch (e) {
      print(e);
      emit(ErrorCourseInfoState());
    }
  }

  void buyCourse(BuildContext context, String id_course, String id) async{
    try{
      var check = await apiService.buyCourse(id_course, id);
      if (check) showDialog(context: context, builder: (context) => AlertDialog(
        content: Text(
          "Заявка успешно отправлена. С вами свяжется наш оператор.",
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 12,
          ),
        ),
        actions: [
          TextButton(child: Text(
            'Ок',
            style: TextStyle(
              color: Colors.blueAccent,
              fontFamily: 'Segoe UI',
              fontSize: 14,
            ),
          ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ));
      if (!check) showDialog(context: context, builder: (context) => AlertDialog(
        content: Text(
          "Ошибка. Повторите попытку.",
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 12,
          ),
        ),
        actions: [
          TextButton(child: Text(
            'Ок',
            style: TextStyle(
              color: Colors.blueAccent,
              fontFamily: 'Segoe UI',
              fontSize: 14,
            ),
          ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ));
    }catch(e) {
      showDialog(context: context, builder: (context) => AlertDialog(
        content: Text(
          "Ошибка. Повторите попытку.",
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 12,
          ),
        ),
        actions: [
          TextButton(child: Text(
            'Ок',
            style: TextStyle(
              color: Colors.blueAccent,
              fontFamily: 'Segoe UI',
              fontSize: 14,
            ),
          ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ));
    }
  }

  void sendQuestion(BuildContext context, String question, String id, String avatar, String balls) async{
    try{
      var checkQuestion = await apiService.sendCourseQuestions(id, question);
      if (!checkQuestion) {
        initial(id, avatar, balls);
        showDialog(context: context, builder: (context) => AlertDialog(
          content: Text(
            "Ошибка при отправке вопроса. Задайте вопрос ещё раз.",
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 12,
            ),
          ),
          actions: [
            TextButton(child: Text(
              'Ок',
              style: TextStyle(
                color: Colors.blueAccent,
                fontFamily: 'Segoe UI',
                fontSize: 14,
              ),
            ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ));
      }
    } catch (e) {
      initial(id, avatar, balls);
      showDialog(context: context, builder: (context) => AlertDialog(
        content: Text(
          "Ошибка при отправке вопроса. Задайте вопрос ещё раз.",
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 12,
          ),
        ),
        actions: [
          TextButton(child: Text(
            'Ок',
            style: TextStyle(
              color: Colors.blueAccent,
              fontFamily: 'Segoe UI',
              fontSize: 14,
            ),
          ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ));
    }
  }
}