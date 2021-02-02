import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/settings/settingscubit.dart';
import 'package:isbusiness/cubit/settings/settingsstate.dart';
import 'package:url_launcher/url_launcher.dart';


class SettingsScreen extends StatelessWidget {
  _launchURL() async {
    const url = 'https://isbusiness.ru';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is InitialSettingsState) {
            context.bloc<SettingsCubit>().initial();
          }
          if (state is LoadedSettingsState) {
            return Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Text(
                    "Настройки",
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                body: Container(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 60.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Уведомления",
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 16,
                                    ),
                                  ),
                                  Switch(
                                    value: state.push,
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: Colors.blueAccent,
                                    activeColor: Colors.blueAccent,
                                    onChanged: (bool value) {
                                      context.bloc<SettingsCubit>().setPush(value);
                                    },
                                  ),
                                ],
                              )
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                child: new ListTile(
                                  leading: Padding(padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0), child: Image.asset("assets/images/info.png")),
                                  title: Text(
                                    "О платформе",
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 16,
                                    ),
                                  ),
                                  onTap: _launchURL,
                                ),
                                decoration: BoxDecoration(
                                    border: new Border(
                                        bottom: new BorderSide(color: Colors.black26)
                                    )
                                )
                            ),
                            Container(
                                child: new ListTile(
                                  leading: Padding(padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0), child: Image.asset("assets/images/feedback.png")),
                                  title: Text(
                                    "Обратная связь",
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 16,
                                    ),
                                  ),
                                  onTap: _launchURL,
                                ),
                                decoration: BoxDecoration(
                                    border: new Border(
                                        bottom: new BorderSide(color: Colors.black26)
                                    )
                                )
                            ),
                            ListTile(
                              leading: Padding(padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0), child: Image.asset("assets/images/like.png")),
                              title: Text(
                                "Партнерство и публикации",
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 16,
                                ),
                              ),
                              onTap: _launchURL,
                            ),
                          ],
                        ),
                      ],
                    )
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