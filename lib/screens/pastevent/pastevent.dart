import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/eventpastinfo/eventpastinfocubit.dart';
import 'package:isbusiness/cubit/eventpastinfo/eventpastinfostate.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EventPastInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventPastInfoCubit, EventPastInfoState>(
      builder: (context, state) {
        if (state is LoadedEventPastInfoState) {
          YoutubePlayerController _controller = YoutubePlayerController(
            initialVideoId: state.video,
            flags: YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
            ),
          );

          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
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
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: Text(
                            state.date,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            state.short_location,
                            style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: Colors.black54
                            ),
                            textAlign: TextAlign.left,
                          ),
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
              ],
            ),
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