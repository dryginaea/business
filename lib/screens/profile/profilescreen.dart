import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isbusiness/cubit/courseinfo/courseinfocubit.dart';
import 'package:isbusiness/cubit/eventinfo/eventinfocubit.dart';
import 'package:isbusiness/cubit/eventpastinfo/eventpastinfocubit.dart';
import 'package:isbusiness/cubit/profile/profilecubit.dart';
import 'package:isbusiness/cubit/profile/profilestate.dart';
import 'package:isbusiness/cubit/shop/shopcubit.dart';
import 'package:isbusiness/router/router.dart';
import 'package:isbusiness/screens/editprofile/editprofile.dart';
import 'package:isbusiness/screens/profile/course.dart';
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
                      fontSize: 22,
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
                          IconButton(icon: SvgPicture.asset("assets/images/qrcode.svg", color: Colors.black45, height: 50), onPressed: () {
                            showDialog(context: context, builder: (context) => AlertDialog(
                              insetPadding: EdgeInsets.symmetric(horizontal: 20),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 200.0,
                                      height: 200.0,
                                      child: QrImage(
                                        data: "{\"id_user\": " + state.user.id + "}",
                                        version: QrVersions.auto,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                          }, iconSize: 40.0),
                          if (state.avatar == null) CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.black12,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
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
                                padding: EdgeInsets.all(20.0),
                                child: Image(image: AssetImage("assets/images/user.png")),
                              ),
                            ),
                            errorWidget: (context, url, error) => CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.black12,
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Image(image: AssetImage("assets/images/user.png")),
                              ),
                            ),
                          ),
                          IconButton(
                              icon: Image.asset("assets/images/edit.png"),
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(state.avatar, state.user.surname, state.user.name, state.user.last_name, state.interests, state.user.email, state.user.phone, int.parse(state.user.type) == 1, context)))
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
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                        child: Text(
                          state.balls + " баллов",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 22,
                          ),
                        )
                    ),
                    Divider(),
                    ListTile(
                        dense:true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          'Привилегии',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                        ),
                        onTap: () => Navigator.pushNamed(context, privilegeRoute)
                    ),
                    Divider(),
                    ListTile(
                        dense:true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          'Мои курсы',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                        ),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MyCourseList(state.courses, state.avatar, state.balls)))
                    ),
                    Divider(),
                    ListTile(
                        dense:true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          'Посещённые мероприятия',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                        ),
                        onTap: () => Navigator.pushNamed(context, pastEventsRoute)
                    ),
                    Divider(),
                    if (state.user.type == "12") ListTile(
                        dense:true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          'Выйти',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                        ),
                        onTap: () {
                          context.bloc<ProfileCubit>().logout();
                          Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);
                        }
                    ),
                    if (state.user.type == "12") Divider(),
                    if (state.tempProduct != null && int.parse(state.tempProduct.cost_balls) <= int.parse(state.balls)) Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
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
                        margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
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
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                      child: Text(
                        "Мои мероприятия",
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state.myProjects.length == 0) GestureDetector(
                        child: Container(
                          height: 250,
                          child: Container(
                            height: 250,
                            child: Image.asset("assets/images/myprojectsnull.png"),
                          ),
                        ),
                      onTap: () => Navigator.pushNamed(context, pastEventsRoute),
                    ),
                    if (state.myProjects.length == 1) GestureDetector(
                        onTap: () {
                          context.bloc<EventInfoCubit>().initial(state.myProjects.first.id, state.myProjects.first.dateDay, state.myProjects.first.location, state.avatar, state.balls);
                          Navigator.pushNamed(context, eventInfoRoute);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
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
                                          imageUrl: state.myProjects.first.image,
                                          placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                                          errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
                                        ),
                                      )),
                                  if (state.myProjects.first.isOnline) Align(alignment: Alignment.topRight, child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    margin: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: Colors.red
                                    ),
                                    child: Text(
                                      " в эфире ",
                                      style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 12,
                                          color: Colors.white
                                        //fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )),
                                  if (int.parse(state.myProjects.first.cost_balls) > 0) Container(
                                    padding: EdgeInsets.all(5.0),
                                    margin: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: Colors.amberAccent
                                    ),
                                    child: Text(
                                      "- " + state.myProjects.first.cost_balls + " баллов",
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 12,
                                        //fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  if (int.parse(state.myProjects.first.give_balls) > 0) Container(
                                    padding: EdgeInsets.all(5.0),
                                    margin: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: Colors.amberAccent
                                    ),
                                    child: Text(
                                      "+ " + state.myProjects.first.give_balls + " баллов",
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
                                  state.myProjects.first.name,
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
                                state.myProjects.first.dateDay,
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
                        )
                    ),
                    if (state.myProjects.length > 1) Container(
                      height: 250,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 10.0),
                            ),
                            for (var project in state.myProjects) GestureDetector(
                                onTap: () {
                                  context.bloc<EventInfoCubit>().initial(project.id, project.dateDay, project.location, state.avatar, state.balls);
                                  Navigator.pushNamed(context, eventInfoRoute);
                                },
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
                                          if (project.isOnline) Align(alignment: Alignment.topRight, child: Container(
                                            padding: EdgeInsets.all(5.0),
                                            margin: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15.0),
                                                color: Colors.red
                                            ),
                                            child: Text(
                                              " в эфире ",
                                              style: TextStyle(
                                                  fontFamily: 'Segoe UI',
                                                  fontSize: 12,
                                                  color: Colors.white
                                                //fontWeight: FontWeight.w700,
                                              ),
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
                                        project.dateDay,
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
                                )
                            )
                          ]
                      ),
                    ),
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