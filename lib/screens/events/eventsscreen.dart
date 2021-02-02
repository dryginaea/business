import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/cubit/eventinfo/eventinfocubit.dart';
import 'package:isbusiness/cubit/events/eventscubit.dart';
import 'package:isbusiness/cubit/events/eventsstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/menu/menucubit.dart';
import 'package:isbusiness/cubit/menu/menustate.dart';
import 'package:isbusiness/cubit/projectinfo/projectinfocubit.dart';
import 'package:isbusiness/router/router.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
        builder: (context, state) {
          if (state is InitialEventsState) {
            context.bloc<EventsCubit>().initial();
          }

          if (state is LoadedEventsState) {
            var currents = List<ValueNotifier<int>>();
            for (int i = 0; i < state.projects.length; i++) {
              currents.add(ValueNotifier<int>(0));
            }
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0.0,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 4, child: Image.asset('assets/images/logo.png')),
                      Expanded(flex: 3, child: Container(
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
                      if (state.avatar == null) Expanded(flex: 1, child: GestureDetector(
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.black12,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Image(image: AssetImage("assets/images/user.png")),
                          ),
                        ),
                        onTap: () => context.bloc<MenuCubit>().emit(InitialMenuState(3)),
                      )),
                      if (state.avatar != null) Expanded(flex: 1, child: GestureDetector(
                        child: CachedNetworkImage(
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
                        ),
                        onTap: () => context.bloc<MenuCubit>().emit(InitialMenuState(3)),
                      )),
                    ],
                  ),
                ),
                body: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                      child: Text(
                        "Афиша мероприятий",
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state.projects.length == 0) Container(
                      height: 500,
                      alignment: Alignment.center,
                      child:
                      Text(
                        "Мероприятий пока нет",
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          color: Colors.black45,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (state.projects.length > 0) for (var project in state.projects) Container(
                        height: 6 * MediaQuery.of(context).size.width / 8,
                      child: Stack(
                        children: [
                          if (project.events.length > 0) Align(
                            alignment: Alignment.topCenter,
                            child: CirclePageIndicator(
                              selectedDotColor: Colors.indigoAccent,
                              dotColor: Colors.black26,
                              size: 6.0,
                              itemCount: project.events.length + 1,
                              currentPageNotifier: currents[state.projects.indexOf(project)],
                            ),
                          ),
                          PageView(
                            onPageChanged: (int value) {
                              currents[state.projects.indexOf(project)].value = value;
                            },
                            children: [
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                                  width: 300,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  context.bloc<ProjectInfoCubit>().initial(project.id, project.events, state.avatar, state.balls);
                                  Navigator.pushNamed(context, projectInfoRoute);
                                },
                              ),
                              for (var event in project.events) GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                                  width: 300,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
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
                                              if (event.isOnline) Align(alignment: Alignment.topRight, child: Container(
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
                                              if (int.parse(event.cost_balls) > 0) Container(
                                                padding: EdgeInsets.all(5.0),
                                                margin: EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15.0),
                                                    color: Colors.amberAccent
                                                ),
                                                child: Text(
                                                  "- " + event.cost_balls + " баллов",
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe UI',
                                                    fontSize: 12,
                                                    //fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              if (int.parse(event.give_balls) > 0) Container(
                                                padding: EdgeInsets.all(5.0),
                                                margin: EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15.0),
                                                    color: Colors.amberAccent
                                                ),
                                                child: Text(
                                                  "+ " + event.give_balls + " баллов",
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe UI',
                                                    fontSize: 12,
                                                    //fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                                        child: Text(
                                          event.name,
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
                                        event.dateDay,
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
                                  context.bloc<EventInfoCubit>().initial(event.id, event.dateDay, event.location, state.avatar, state.balls);
                                  Navigator.pushNamed(context, eventInfoRoute);
                                },
                              )
                            ],
                          )
                        ],
                      )
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
            ),
          );
        }
    );
  }
}
