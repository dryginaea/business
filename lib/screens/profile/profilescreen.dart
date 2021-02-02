import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/courseinfo/courseinfocubit.dart';
import 'package:isbusiness/cubit/eventpastinfo/eventpastinfocubit.dart';
import 'package:isbusiness/cubit/profile/profilecubit.dart';
import 'package:isbusiness/cubit/profile/profilestate.dart';
import 'package:isbusiness/cubit/shop/shopcubit.dart';
import 'package:isbusiness/router/router.dart';
import 'package:isbusiness/screens/editprofile/editprofile.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          print(state);
          if (state is InitialProfileState) {
            context.bloc<ProfileCubit>().initial();
          }

          if (state is LoadedProfileState) {
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0.0,
                  title: Text(
                    "Профиль",
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  actions: [
                    IconButton(
                        icon: Container(padding: EdgeInsets.all(10.0),child: Image.asset("assets/images/settings.png")),
                        onPressed: () => Navigator.pushNamed(context, settingsRoute)
                    )
                  ],
                ),
                body: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(icon: Image.asset("assets/images/link.png"), onPressed: null),
                          if (state.avatar == null) CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.black12,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Image(image: AssetImage("assets/images/user.png")),
                            ),
                          ),
                          if (state.avatar != null) CachedNetworkImage(
                            fit: BoxFit.contain,
                            imageUrl: state.avatar,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.black12,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image(image: AssetImage("assets/images/user.png")),
                              ),
                            ),
                            errorWidget: (context, url, error) => CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.black12,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image(image: AssetImage("assets/images/user.png")),
                              ),
                            ),
                          ),
                          IconButton(
                              icon: Image.asset("assets/images/edit.png"),
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(state.avatar, state.user.surname, state.user.name, state.user.last_name, state.interests, state.user.email, state.user.phone, int.parse(state.user.type) == 0, context)))
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                      child: Text(
                        state.user.surname + " " + state.user.name + " " + state.user.last_name,
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ),
                    Container(
                      height: 150,
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                        child: QrImage(
                          data: "{\"id_user\": " + state.user.id + "}",
                          version: QrVersions.auto,
                        ),
                    ),
                    Container(
                        height: 38,
                        margin: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
                        child: FlatButton(
                          textColor: Colors.indigoAccent,
                          shape: RoundedRectangleBorder(side: BorderSide(
                            color: Colors.indigoAccent,
                          )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Привилегии',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () => Navigator.pushNamed(context, privilegeRoute)
                        )),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 40.0),
                        child: Text(
                          state.balls + " баллов",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                    ),
                    if (state.tempProduct != null && int.parse(state.tempProduct.cost_balls) <= int.parse(state.balls)) Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                        color: Color.fromARGB(255, 243, 246, 251),
                        child: Row(
                          children: [
                            Flexible(flex: 1, child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: CachedNetworkImage(
                                    imageUrl: state.tempProduct.image,
                                    placeholder: (context, url) => Container(),
                                    errorWidget: (context, url, error) => Container(),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(35.0),
                                  child: Image.asset("assets/images/check.png"),
                                )
                              ],
                            )),
                            Flexible(flex: 2, child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), child: Text(
                                  state.tempProduct.name,
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),),
                                Padding(padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0), child: Text(
                                  state.tempProduct.cost_balls + " баллов",
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),),
                                Container(
                                    margin: EdgeInsets.all(20.0),
                                    child: GestureDetector(
                                      child: Text(
                                        "Обменять",
                                        style: TextStyle(
                                          color: Colors.indigoAccent,
                                          fontFamily: 'Segoe UI',
                                          fontSize: 13,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      onTap: () {
                                        showDialog(context: context, builder: (context) => AlertDialog(
                                          content: Text(
                                            "Обменять?",
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 16,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(child: Text(
                                              'Отмена',
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontFamily: 'Segoe UI',
                                                fontSize: 14,
                                              ),
                                            ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(child: Text(
                                              'Обменять',
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontFamily: 'Segoe UI',
                                                fontSize: 14,
                                              ),
                                            ),
                                              onPressed: () {
                                                context.bloc<ShopCubit>().buyProduct(state.tempProduct.id, context);
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ));
                                      },
                                    )
                                )
                              ],
                            ),)
                          ],
                        )
                    ),
                    if (state.tempProduct != null && int.parse(state.tempProduct.cost_balls) > int.parse(state.balls)) Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                        color: Color.fromARGB(255, 211, 221, 233),
                        child: Row(
                          children: [
                            Flexible(flex: 1, child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: CachedNetworkImage(
                                imageUrl: state.tempProduct.image,
                                placeholder: (context, url) => Container(),
                                errorWidget: (context, url, error) => Container(),
                              ),
                            )),
                            Flexible(flex: 2, child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), child: Text(
                                  state.tempProduct.name,
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),),
                                Padding(padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0), child: Text(
                                  state.tempProduct.cost_balls + " баллов",
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),),
                                Container(
                                  margin: EdgeInsets.all(20.0),
                                  height: 5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: LinearProgressIndicator(
                                      value: int.parse(state.balls) / int.parse(state.tempProduct.cost_balls) ?? 0.0,
                                      backgroundColor: Color.fromARGB(255, 243, 246, 251),
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.indigoAccent),
                                    ),
                                  ),
                                )
                              ],
                            ),)
                          ],
                        )
                    ),
                    if (state.nextProduct != null && int.parse(state.nextProduct.cost_balls) <= int.parse(state.balls)) Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                        color: Color.fromARGB(255, 243, 246, 251),
                        child: Row(
                          children: [
                            Flexible(flex: 1, child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: CachedNetworkImage(
                                    imageUrl: state.nextProduct.image,
                                    placeholder: (context, url) => Container(),
                                    errorWidget: (context, url, error) => Container(),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(35.0),
                                  child: Image.asset("assets/images/check.png"),
                                )
                              ],
                            )),
                            Flexible(flex: 2, child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), child: Text(
                                  state.nextProduct.name,
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),),
                                Padding(padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0), child: Text(
                                  state.nextProduct.cost_balls + " баллов",
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),),
                                Container(
                                    margin: EdgeInsets.all(20.0),
                                    child: GestureDetector(
                                      child: Text(
                                        "Обменять",
                                        style: TextStyle(
                                          color: Colors.indigoAccent,
                                          fontFamily: 'Segoe UI',
                                          fontSize: 13,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      onTap: () {
                                        showDialog(context: context, builder: (context) => AlertDialog(
                                          content: Text(
                                            "Обменять?",
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 16,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(child: Text(
                                              'Отмена',
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontFamily: 'Segoe UI',
                                                fontSize: 14,
                                              ),
                                            ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(child: Text(
                                              'Обменять',
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontFamily: 'Segoe UI',
                                                fontSize: 14,
                                              ),
                                            ),
                                              onPressed: () {
                                                context.bloc<ShopCubit>().buyProduct(state.nextProduct.id, context);
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ));
                                      },
                                    )
                                )
                              ],
                            ),)
                          ],
                        )
                    ),
                    if (state.nextProduct != null && int.parse(state.nextProduct.cost_balls) > int.parse(state.balls)) Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                        color: Color.fromARGB(255, 211, 221, 233),
                        child: Row(
                          children: [
                            Flexible(flex: 1, child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: CachedNetworkImage(
                                imageUrl: state.nextProduct.image,
                                placeholder: (context, url) => Container(),
                                errorWidget: (context, url, error) => Container(),
                              ),
                            ),),
                            Flexible(flex: 2, child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), child: Text(
                                  state.nextProduct.name,
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),),
                                Padding(padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0), child: Text(
                                  state.nextProduct.cost_balls + " баллов",
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),),
                                Container(
                                  margin: EdgeInsets.all(20.0),
                                  height: 5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: LinearProgressIndicator(
                                      value: int.parse(state.balls) / int.parse(state.nextProduct.cost_balls) ?? 0.0,
                                      backgroundColor: Color.fromARGB(255, 243, 246, 251),
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.indigoAccent),
                                    ),
                                  ),
                                )
                              ],
                            ),)
                          ],
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
                      child: Text(
                        "Мои курсы",
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state.courses.length == 0) Container(
                      height: 250,
                      color: Color.fromARGB(200, 231, 235, 243),
                      alignment: Alignment.center,
                      child: Text(
                        "Нет активных курсов",
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.black45,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state.courses.length != 0) Container(
                      height: 250,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 10.0),
                            ),
                            for (var course in state.courses) GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.only(right: 10.0),
                                  width: 300,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AspectRatio(
                                          aspectRatio: 16/9,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(4.0),
                                            child: CachedNetworkImage(
                                              imageUrl: course.image,
                                              placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                                              errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
                                            ),
                                          )),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                                        child: Text(
                                          course.name,
                                          style: TextStyle(
                                            fontFamily: 'Segoe UI',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  context.bloc<CourseInfoCubit>().initial(course.id, state.avatar, state.balls);
                                  Navigator.pushNamed(context, courseInfoRoute);
                                }
                            )
                          ]
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
                      child: Text(
                        "Прошедшие мероприятия",
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state.pastProject.length == 0) Container(
                      height: 250,
                      color: Color.fromARGB(200, 231, 235, 243),
                      alignment: Alignment.center,
                      child: Text(
                        "Нет прошедших мероприятий",
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.black45,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state.pastProject.length > 0) Container(
                      height: 250,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 10.0),
                            ),
                            for (var project in state.pastProject) GestureDetector(
                              child: Container(
                                padding: EdgeInsets.only(right: 10.0),
                                width: 300,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        AspectRatio(
                                            aspectRatio: 16/9,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(4.0),
                                              child: CachedNetworkImage(
                                                imageUrl: project.image,
                                                placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                                                errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
                                              ),
                                            )),
                                        if (int.parse(project.cost_balls) > 0) Container(
                                          padding: EdgeInsets.all(5.0),
                                          margin: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15.0),
                                              color: Colors.amberAccent
                                          ),
                                          child: Text(
                                            "- " + project.cost_balls + " баллов",
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 12,
                                              //fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        if (int.parse(project.give_balls) > 0) Container(
                                          padding: EdgeInsets.all(5.0),
                                          margin: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15.0),
                                              color: Colors.amberAccent
                                          ),
                                          child: Text(
                                            "+ " + project.give_balls + " баллов",
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 12,
                                              //fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                                      child: Text(
                                        project.name,
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      project.dateTime,
                                      style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 16,
                                          color: Colors.black54
                                        //fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                context.bloc<EventPastInfoCubit>().initial(project.id, project.dateDay, project.location);
                                Navigator.pushNamed(context, pastEventRoute);
                              },
                            )
                          ]
                      ),
                    ),
                    if (state.pastProject.length > 0) Container(
                        height: 38,
                        margin: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 30.0),
                        child: FlatButton(
                          textColor: Colors.indigoAccent,
                          shape: RoundedRectangleBorder(side: BorderSide(
                            color: Colors.indigoAccent,
                          )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Смотреть все',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, pastEventsRoute);
                          },
                        )),
                  ],
                )
            );
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
            ),
          );
        }
    );
  }
}