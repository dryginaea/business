import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/eventpastinfo/eventpastinfocubit.dart';
import 'package:isbusiness/cubit/pastevents/pasteventscubit.dart';
import 'package:isbusiness/cubit/pastevents/pasteventsstate.dart';
import 'package:isbusiness/router/router.dart';

class PastEventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsPastCubit, EventsPastState>(
        builder: (context, state) {
          if (state is InitialPastEventsState) {
            context.bloc<EventsPastCubit>().initial();
          }

          if (state is LoadedPastEventsState) {
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0.0,
                  title: Text("Прошедшие мероприятия")
                ),
                body: ListView(
                  children: [
                    for (var event in state.events) GestureDetector(
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
                                            imageUrl: event.image,
                                            placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                                            errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
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
                            Divider()
                          ],
                        ),
                      ),
                      onTap: () {
                        context.bloc<EventPastInfoCubit>().initial(event.id, event.dateDay, event.location);
                        Navigator.pushNamed(context, pastEventRoute);
                      },
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
