
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isbusiness/cubit/menu/menucubit.dart';
import 'package:isbusiness/cubit/menu/menustate.dart';
import 'package:isbusiness/screens/archive/archivescreen.dart';
import 'package:isbusiness/screens/events/eventsscreen.dart';
import 'package:isbusiness/screens/home/homescreen.dart';
import 'package:isbusiness/screens/profile/profilescreen.dart';
import 'package:isbusiness/screens/shop/shopscreen.dart';

class Menu extends StatelessWidget {
  final List<Widget> _road = [
    HomeScreen(),
    EventsScreen(),
    ArchiveScreen(),
    ShopScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(builder: (context, state) {
      if (state is InitialMenuState) {
        return Scaffold(
            body: _road[state.current],
            bottomNavigationBar: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: (int value) => context.bloc<MenuCubit>().emit(InitialMenuState(value)),
                currentIndex: state.current,
                type: BottomNavigationBarType.fixed,
                items: [
                  if (state.current == 0) BottomNavigationBarItem(
                      icon: Container(height: 20, child: Image.asset("assets/images/menu_home_select.png", fit: BoxFit.contain)), title: Text("")),
                  if (state.current != 0) BottomNavigationBarItem(
                      icon: Container(height: 20, child: Image.asset("assets/images/menu_home.png", fit: BoxFit.contain)), title: Text("")),
                  if (state.current == 1) BottomNavigationBarItem(
                      icon: Container(height: 20, child: Image.asset("assets/images/menu_events_select.png", fit: BoxFit.contain)), title: Text("")),
                  if (state.current != 1) BottomNavigationBarItem(
                      icon: Container(height: 20, child: Image.asset("assets/images/menu_events.png", fit: BoxFit.contain)), title: Text("")),
                  if (state.current == 2) BottomNavigationBarItem(
                      icon: SvgPicture.asset("assets/images/archive.svg", color: Colors.indigoAccent, height: 28), title: Text("")),
                  if (state.current != 2) BottomNavigationBarItem(
                      icon: SvgPicture.asset("assets/images/archive.svg", color: Colors.black45, height: 28), title: Text("")),
                  if (state.current == 3) BottomNavigationBarItem(
                      icon: Container(height: 20, child: Image.asset("assets/images/menu_shop_select.png", fit: BoxFit.contain)), title: Text("")),
                  if (state.current != 3) BottomNavigationBarItem(
                      icon: Container(height: 20, child: Image.asset("assets/images/menu_shop.png", fit: BoxFit.contain)), title: Text("")),
                  if (state.current == 4) BottomNavigationBarItem(
                      icon: Container(height: 20, child: Image.asset("assets/images/menu_user_select.png", fit: BoxFit.contain)), title: Text("")),
                  if (state.current != 4) BottomNavigationBarItem(
                      icon: Container(height: 20, child: Image.asset("assets/images/user.png", fit: BoxFit.contain)), title: Text("")),
                ]));
      }

      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
        ),
      );
    });
  }
}