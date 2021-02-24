import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:isbusiness/cubit/eventpastinfo/eventpastinfocubit.dart';
import 'package:isbusiness/cubit/eventpastinfo/eventpastinfostate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EventPastInfo extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
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
                          width: double.infinity,
                          child: Html(
                            data: state.description,
                            onLinkTap: (url) {
                              _launchURL(url);
                            },
                          )
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