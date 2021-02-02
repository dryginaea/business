import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:isbusiness/cubit/lessoninfo/lessoninfocubit.dart';
import 'package:isbusiness/cubit/lessoninfo/lessoninfostate.dart';
import 'package:isbusiness/data/questions/questions.dart';
import 'package:url_launcher/url_launcher.dart';

class LessonInfo extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonInfoCubit, LessonInfoState>(
      builder: (context, state) {
        if (state is LoadedLessonInfoState) {
          var questionController = TextEditingController();
          print(state.lesson.content_not_buy);
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Row(
                children: [
                  Expanded(flex: 7, child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                          state.balls + "Б",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                            //fontWeight: FontWeight.w700,
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
            body: Column(
              children: [
                if (!state.check) Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: AlertDialog(
                        content: Text(
                          "Уроки будут доступны после приобретения курса",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    )
                  ],
                )),
                if (state.check) Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Color.fromARGB(200, 231, 235, 243),
                          padding: EdgeInsets.all(10.0),
                          width: double.infinity,
                          child: Text(
                            state.lesson.title,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          color: Color.fromARGB(200, 231, 235, 243),
                          padding: EdgeInsets.all(10.0),
                          width: double.infinity,
                          child: Html(
                            data: state.lesson.content_buy,
                            onLinkTap: (url) {
                              _launchURL(url);
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          width: double.infinity,
                          color: Color.fromARGB(200, 231, 235, 243),
                          child: CachedNetworkImage(
                            imageUrl: state.lesson.image,
                            placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                            errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
                          ),
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
                                  cursorColor: Colors.indigo,
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
                                var list = state.questions;
                                list.insert(0, Question(questionController.text, "", state.user.id, state.user.name));
                                context.bloc<LessonInfoCubit>().emit(LoadingLessonInfoState());
                                context.bloc<LessonInfoCubit>().emit(LoadedLessonInfoState(state.id, state.lesson, state.user, state.avatar, state.balls, state.check, list, state.lessons, state.index));
                              },
                            )),
                        for (var question in state.questions) Column(
                          children: [
                            Container(
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
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (state.index != 0) Expanded(flex: 2, child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 20.0),
                          child: TextButton(
                              onPressed: () {
                                context.bloc<LessonInfoCubit>().initial(state.lessons[state.index - 1].id,
                                    state.user, state.avatar, state.balls, state.check, state.questions,
                                    state.lessons, state.index - 1);
                              },
                              child: Text(
                                "Предыдущий урок",
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.left,
                              )
                          )
                      )),
                      if (state.index == 0) Expanded(flex: 2, child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 20.0),
                          child: Container()
                      )),
                      Expanded(flex: 1, child: Center()),
                      if (state.index + 1 != state.lessons.length) Expanded(flex: 2, child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 20.0),
                          child: TextButton(
                              onPressed: () {
                                context.bloc<LessonInfoCubit>().initial(state.lessons[state.index + 1].id,
                                    state.user, state.avatar, state.balls, state.check, state.questions,
                                    state.lessons, state.index + 1);
                              },
                              child: Text(
                                "Следующий урок",
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  color: Colors.indigoAccent,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.right,
                              )
                          )
                      )),
                      if (state.index + 1 == state.lessons.length) Expanded(flex: 2, child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 20.0),
                          child: TextButton(
                              onPressed: null,
                              child: Container()
                      )),)
                    ],
                  ),
                )
              ],
            )
          );
        }

        return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
            ),
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
            )
        );
      },
    );
  }
}