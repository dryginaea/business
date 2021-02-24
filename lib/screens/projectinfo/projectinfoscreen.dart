import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/eventinfo/eventinfocubit.dart';
import 'package:isbusiness/cubit/projectinfo/projectinfocubit.dart';
import 'package:isbusiness/cubit/projectinfo/projectinfostate.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:isbusiness/router/router.dart';

class ProjectInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectInfoCubit, ProjectInfoState>(
      builder: (context, state) {

        if (state is LoadedProjectInfoState) {
          YoutubePlayerController _controller = YoutubePlayerController(
            initialVideoId: state.video,
            flags: YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
            ),
          );

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
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: YoutubePlayer(controller: _controller),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                          child: Text(
                            "Расписание",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        for(var event in state.events) GestureDetector(
                          child: Container(
                              width: double.infinity,
                              color: Color.fromARGB(200, 231, 235, 243),
                              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0), child: Text(
                                    event.name,
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),),
                                  Text(
                                    "Спикер: " + event.speakers,
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14,
                                        color: Colors.black54
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Padding(padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 3.0), child: Text(
                                    event.dateTime,
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),),
                                  Text(
                                    event.short_location,
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 12,
                                        color: Colors.black54
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Divider()
                                ],
                              )
                          ),
                          onTap: () {
                            context.bloc<EventInfoCubit>().initial(event.id, event.dateDay, event.location, state.avatar, state.balls);
                            Navigator.pushNamed(context, eventInfoRoute);
                          },
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                          child: Text(
                            "О мероприятии",
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
                          width: double.infinity,
                          child: Text(
                            state.description,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                if (!state.check) Container(
                    height: 38,
                    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
                    child: FlatButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Участвовать',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        context.bloc<ProjectInfoCubit>().registration(context, state.id, state.name, state.video, state.description, state.events, state.avatar, state.balls);
                      },
                    )),
                if (state.check) Container(
                    height: 38,
                    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
                    child: FlatButton(
                      textColor: Colors.indigoAccent,
                      color: Color.fromARGB(200, 211, 221, 233),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Отменить участия',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        context.bloc<ProjectInfoCubit>().registrationCancel(context, state.id, state.name, state.video, state.description, state.events, state.avatar, state.balls);
                      },
                    )),
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