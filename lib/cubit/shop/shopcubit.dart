import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:isbusiness/cubit/events/eventscubit.dart';
import 'package:isbusiness/cubit/home/homecubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/profile/profilecubit.dart';
import 'package:isbusiness/data/product/product.dart';

import 'shopstate.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit(this.apiService) : super(InitialShopState());

  ApiService apiService;

  void initial() async{
    emit(LoadingShopState());
    try {
      var balls = await apiService.getBalls();
      var courses = await apiService.getCourses([1, 2, 3, 4, 5, 6, 7, 8, 16, 17, 18, 19, 20, 21, 22, 23, 24], -1);
      var products = await apiService.getProducts();
      var user = await apiService.getUserData();
      var checkAvatar = await apiService.checkUserAvatar();
      var avatar;
      if (checkAvatar) {
        var date = await apiService.getAvatar();
        avatar = 'https://inficomp.ru/anketa/api/avatars/${user.id}.jpg' + date;
      }
      emit(LoadedShopState(balls, products.products, avatar, courses.courses, [1, 2, 3, 4, 5, 6, 7, 8, 16, 17, 18, 19, 20, 21, 22, 23, 24], -1));
    } catch (e) {
      emit(ErrorShopState());
    }
  }

  void change(String balls, List<Product> products, String avatar, List<int> interests, int free) async{
    emit(LoadingShopState());
    try {
      var courses = await apiService.getCourses(interests, free);
      emit(LoadedShopState(balls, products, avatar, courses.courses, interests, free));
    } catch (e) {
      emit(ErrorShopState());
    }
  }

  void buyProduct(String id, BuildContext context) async{
    try{
      showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
      ),));
      var balance = await apiService.buyItem(id);
      Navigator.pop(context);
      context.bloc<HomeCubit>().initial();
      context.bloc<ShopCubit>().initial();
      context.bloc<EventsCubit>().initial();
      context.bloc<ProfileCubit>().initial();
      print(balance);
    } catch(e) {
      showDialog(context: context, builder: (context) => AlertDialog(
        content: Text(
          "Произошла ошибка. Повторите попытку.",
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 12,
          ),
        ),
        actions: [
          TextButton(child: Text(
            'Ок',
            style: TextStyle(
              color: Colors.blueAccent,
              fontFamily: 'Segoe UI',
              fontSize: 14,
            ),
          ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      ));
    }
  }

  void sendPromocode(String promo) async{
    await apiService.savePromocode(promo);
  }
}