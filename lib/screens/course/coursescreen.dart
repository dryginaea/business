import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:isbusiness/cubit/courseinfo/courseinfocubit.dart';
import 'package:isbusiness/cubit/courseinfo/courseinfostate.dart';
import 'package:isbusiness/cubit/lessoninfo/lessoninfocubit.dart';
import 'package:isbusiness/data/questions/questions.dart';
import 'package:isbusiness/router/router.dart';
import 'package:isbusiness/screens/course/rates.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CourseInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseInfoCubit, CourseInfoState>(
      builder: (context, state) {
        if (state is LoadedCourseInfoState) {
          print(state.video);
          var questionController = TextEditingController();
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
              title: Row(
                children: [
                  Expanded(flex: 7, child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                          state.balls + "Б",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.right
                      )),),
                  if (state.avatar == null) Expanded(flex: 1, child: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.black12,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image(image: AssetImage("assets/images/user.png")),
                    ),
                  ),),
                  if (state.avatar != null) Expanded(flex: 1, child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: state.avatar,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.black12,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Image(image: AssetImage("assets/images/user.png")),
                      ),
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.black12,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Image(image: AssetImage("assets/images/user.png")),
                      ),
                    ),
                  ),),
                ],
              ),
            ),
            body: ListView(
              children: [
                Container(
                  height: 250,
                  padding: EdgeInsets.all(10.0),
                  child: WebView(
                    initialUrl: state.video,
                    javascriptMode: JavascriptMode.unrestricted,
                  )
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  child: Text(
                    state.name,
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  color: Color.fromARGB(200, 231, 235, 243),
                  width: double.infinity,
                  child: Html(
                    data: state.htmlBody,
                  ),
                ),
                if (state.check != 0 && state.check != 1) Container(
                    height: 78,
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
                    color: Color.fromARGB(200, 231, 235, 243),
                    child: FlatButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Приобрести',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => RatesScreen(state.rates,state.avatar, state.balls)));
                      },
                    )),
                if (state.check == 0) Container(
                    height: 78,
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
                    color: Color.fromARGB(200, 231, 235, 243),
                    child: FlatButton(
                      textColor: Colors.black54,
                      color: Colors.black26,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Заявка отправлена',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    )),
                if (state.check == 1) Container(
                    height: 78,
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
                    color: Color.fromARGB(200, 231, 235, 243),
                    child: FlatButton(
                      textColor: Colors.black54,
                      color: Colors.black26,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Куплено',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    )),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  color: Color.fromARGB(200, 231, 235, 243),
                  child: Text(
                    "Уроки",
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                for (var lesson in state.lessons) Column(
                  children: [
                    ListTile(
                      onTap: () {
                        context.bloc<LessonInfoCubit>().initial(lesson.id, state.user, state.avatar, state.balls, state.check, state.questions, state.lessons, state.lessons.indexOf(lesson));
                        Navigator.pushNamed(context, lessonInfoRoute);
                      },
                      trailing: Icon(Icons.keyboard_arrow_right),
                      tileColor: Color.fromARGB(200, 231, 235, 243),
                      title: Text(
                        lesson.title,
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      color: Color.fromARGB(200, 231, 235, 243),
                      child: Divider(),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                  width: double.infinity,
                  color: Color.fromARGB(200, 231, 235, 243),
                  child: Text(
                    "Вопрос / Ответ",
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                    width: double.infinity,
                    color: Color.fromARGB(200, 231, 235, 243),
                    child: Theme(
                        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                        child: TextFormField(
                          maxLines: 5,
                          controller: questionController,
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hoverColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.0),
                            labelText: "Введите ваш вопрос...",
                            alignLabelWithHint: true,
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Segoe UI',
                              fontSize: 16,
                            ),
                            prefixStyle: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Segoe UI',
                              fontSize: 16,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(0.0))
                            ),
                          ),
                        )
                    )
                ),
                Container(
                    height: 78,
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
                    color: Color.fromARGB(200, 231, 235, 243),
                    child: FlatButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Отправить',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        if (questionController.text.length > 0) {
                          var list = state.questions;
                          list.insert(0, Question(questionController.text, "", state.user.id, state.user.name));
                          context.bloc<CourseInfoCubit>().emit(LoadingCourseInfoState());
                          context.bloc<CourseInfoCubit>().emit(LoadedCourseInfoState(state.id, state.user, state.name, state.video, state.htmlBody, state.avatar, state.balls, state.check, state.lessons, list, state.rates));
                          context.bloc<CourseInfoCubit>().sendQuestion(context, questionController.text, state.id, state.avatar, state.balls);
                        }
                      },
                    )),
                for (var question in state.questions) Column(
                  children: [
                    if (question.answer.length > 0 || question.id_user == state.user.id) Container(
                      color: Color.fromARGB(200, 231, 235, 243),
                      child: ListTile(
                        leading: CachedNetworkImage(
                          fit: BoxFit.contain,
                          imageUrl: "https://inficomp.ru/anketa/api/avatars/${question.id_user}.jpg",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.black12,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Image(image: AssetImage("assets/images/user.png")),
                            ),
                          ),
                          errorWidget: (context, url, error) => CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.black12,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Image(image: AssetImage("assets/images/user.png")),
                            ),
                          ),
                        ),
                        title: Text(
                          question.name,
                          style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        subtitle: Text(
                          question.question,
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    if (question.answer.length > 0) Container(
                      color: Color.fromARGB(200, 231, 235, 243),
                      child: ListTile(
                        leading: VerticalDivider(),
                        title: ListTile(
                          leading: CircleAvatar(
                            radius: 22.0,
                            backgroundImage: AssetImage("assets/images/admin.png"),
                          ),
                          title: Text(
                            "Администратор",
                            style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          subtitle: Text(
                            question.answer,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 16,
                            ),
                          ),
                        )
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Color.fromARGB(200, 231, 235, 243),
                  height: 40.0,
                )
              ],
            ),
          );
        }

        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            )
        );
      },
    );
  }
}