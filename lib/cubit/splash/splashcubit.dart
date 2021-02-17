import 'package:bloc/bloc.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/cubit/archive/archivecubit.dart';
import 'package:isbusiness/cubit/events/eventscubit.dart';
import 'package:isbusiness/cubit/events/eventsstate.dart';
import 'package:isbusiness/cubit/home/homecubit.dart';
import 'package:isbusiness/cubit/home/homestate.dart';
import 'package:isbusiness/cubit/profile/profilecubit.dart';
import 'package:isbusiness/cubit/profile/profilestate.dart';
import 'package:isbusiness/cubit/settings/settingscubit.dart';
import 'package:isbusiness/cubit/settings/settingsstate.dart';
import 'package:isbusiness/cubit/shop/shopcubit.dart';
import 'package:isbusiness/cubit/shop/shopstate.dart';
import 'package:isbusiness/router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'splashstate.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.apiService) : super(InitialState());

  ApiService apiService;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  void initial(BuildContext context) async{
    emit(LoadingState());
    var version = await apiService.getVersionApp();
    if (version.version != '2.0.5') {
      showDialog(barrierDismissible: false, context: context, builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70.0,
              height: 70.0,
              child: Image.asset('assets/images/ic_launcher.png'),
            ),
            Padding(padding: EdgeInsets.all(10.0), child: Text(
              "Доступна новая версия приложения.",
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),),
            FlatButton(
                textColor: Colors.white,
                color: Colors.blueAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Обновить',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  if (Theme.of(context).platform == TargetPlatform.iOS) {
                    _launchURL('https://apps.apple.com/ru/app/isbusiness/id1537612458');
                  } else _launchURL('https://play.google.com/store/apps/details?id=info.xorcistexo.isbussiness');
                }
            )
          ],
        ),
      ));
    }
    else {
      var token = await apiService.getToken();
      print("TOKEN: $token");
      if (token != null) {
        var projects = await apiService.getProjects();
        var balls = await apiService.getBalls();
        var courses = await apiService.getCourses([1, 2, 3, 4, 5, 6, 7, 8, 16, 17, 18, 19, 20, 21, 22, 23, 24], -1);
        var myCourses = await apiService.getMyCourses();
        var products = await apiService.getProducts();
        var nextProduct = products.products.firstWhere((element) => (int.parse(element.cost_balls) > int.parse(balls)), orElse: () => products.products.last);
        var tempProduct = products.products.first;
        if (products.products.indexOf(nextProduct) - 1 < 0) {
          nextProduct = products.products[1];
        } else tempProduct = products.products[products.products.indexOf(nextProduct) - 1];
        var myProjects = await apiService.getMyEvents();
        var partnerProjects = await apiService.getPartnersEvents();
        var user = await apiService.getUserData();
        var interests = await apiService.getInterests();
        var pastEvents = await apiService.getPastEvents();
        var checkAvatar = await apiService.checkUserAvatar();
        var push = await apiService.getStatusPush();
        var avatar;
        if (checkAvatar) {
          var date = await apiService.getAvatar();
          avatar = 'https://inficomp.ru/anketa/api/avatars/${user.id}.jpg' + date;
        }

        var endEvents = projects.projects.length < 5 ? projects.projects.length : 5;
        var endPastEvents = pastEvents.myevents.length < 3 ? pastEvents.myevents.length : 3;

        context.bloc<HomeCubit>().emit(LoadedHomeState(projects.projects.sublist(0, endEvents), balls, user.name, courses.courses, myProjects.myevents, partnerProjects.projects, avatar));
        context.bloc<EventsCubit>().emit(LoadedEventsState(projects.projects, balls, avatar));
        context.bloc<ShopCubit>().emit(LoadedShopState(balls, products.products, avatar, courses.courses, [1, 2, 3, 4, 5, 6, 7, 8, 16, 17, 18, 19, 20, 21, 22, 23, 24], -1));
        context.bloc<ProfileCubit>().emit(LoadedProfileState(user, balls, tempProduct, nextProduct, pastEvents.myevents.sublist(0, endPastEvents), myCourses.courses, myProjects.myevents, avatar, interests.interests, push));
        context.bloc<ArchiveCubit>().initial();
        context.bloc<SettingsCubit>().emit(LoadedSettingsState(push));
        Navigator.pushReplacementNamed(context, menuRoute);
      }
      else Navigator.pushReplacementNamed(context, loginRoute);
    }
  }
}