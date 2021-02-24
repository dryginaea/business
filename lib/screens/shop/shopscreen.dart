import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/courseinfo/courseinfocubit.dart';
import 'package:isbusiness/cubit/coursespromo/coursespromocubit.dart';
import 'package:isbusiness/cubit/menu/menucubit.dart';
import 'package:isbusiness/cubit/menu/menustate.dart';
import 'package:isbusiness/cubit/shop/shopcubit.dart';
import 'package:isbusiness/cubit/shop/shopstate.dart';
import 'package:isbusiness/router/router.dart';
import 'package:isbusiness/screens/shop/interestsFilter.dart';

class ShopScreen extends StatelessWidget {
  Map<int, String> interests = {
    1: "Производство",
    2: "Продажи",
    3: "Экспорт/Импорт",
    4: "Услуги",
    5: "IT-Технологии",
    6: "Фермерство",
    7: "Сельское хозяйство",
    8: "Женский бизнес",
    16: "Аудит и постороение бизнес-процессов",
    17: "Переговоры и продажи",
    18: "Маркетинг",
    19: "Командообразование и развитие персонала",
    20: "Бухгалтерия и финансовый учёт",
    21: "Управленческий учёт",
    22: "Личная эффективность",
    23: "Франчайзинг",
    24: "Продажи на маркетплейсах"
  };

  Map<int, String> free = {
    -1: "Все",
    1: "Бесплатные"
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: BlocBuilder<ShopCubit, ShopState>(
            builder: (context, state) {
              if (state is InitialShopState) {
                context.bloc<ShopCubit>().initial();
              }

              if (state is LoadedShopState) {
                print(state.interests);
                var promoController = TextEditingController();
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    bottom: TabBar(
                      indicatorColor: Colors.white,
                      labelColor: Colors.indigoAccent,
                      unselectedLabelColor: Colors.black38,
                      tabs: [
                        Text("Курсы",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),),
                        Text("Мерч",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),),
                        Text("Промокод",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),),
                      ],
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 4, child: Text(
                          "Магазин",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Segoe UI',
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),),
                        Expanded(flex: 3, child: Container(
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
                        if (state.avatar == null) Expanded(flex: 1, child: GestureDetector(
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.black12,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Image(image: AssetImage("assets/images/user.png")),
                            ),
                          ),
                          onTap: () => context.bloc<MenuCubit>().emit(InitialMenuState(4)),
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
                          onTap: () => context.bloc<MenuCubit>().emit(InitialMenuState(4)),
                        )),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(flex: 1, child: GestureDetector(
                                  child: Container(
                                    width: double.infinity,
                                    height: 35.0,
                                    margin: EdgeInsets.only(right: 5.0),
                                    padding: EdgeInsets.all(5.0),
                                    color: Color.fromARGB(200, 231, 235, 243),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Интересы",
                                            style: TextStyle(
                                                fontFamily: 'Segoe UI',
                                                fontSize: 15,
                                                color: Colors.black
                                            )
                                        ),
                                        Icon(Icons.arrow_drop_down, color: Colors.black54)
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => Interests(state.interests, interests, state.balls, state.avatar, state.products, state.free)));
                                  },
                                )),
                                Flexible(flex: 1, child: Container(
                                  width: double.infinity,
                                  height: 35.0,
                                  margin: EdgeInsets.only(left: 5.0),
                                  padding: EdgeInsets.all(5.0),
                                  color: Color.fromARGB(200, 231, 235, 243),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                        hint: Text(
                                            "Сортировка",
                                            style: TextStyle(
                                                fontFamily: 'Segoe UI',
                                                fontSize: 15,
                                                color: Colors.black
                                            )
                                        ),
                                        items: <int>[-1, 1].map((int value) {
                                          return new DropdownMenuItem<int>(
                                            value: value,
                                            child: new Text(free[value],
                                              style: TextStyle(
                                                  fontFamily: 'Segoe UI',
                                                  fontSize: 14,
                                                  color: Colors.black),),
                                          );
                                        }).toList(),
                                        onChanged: (int value) {
                                          context.bloc<ShopCubit>().change(state.balls, state.products, state.avatar, state.interests, value);
                                        },
                                      )
                                  ),
                                )),
                              ],
                            ),
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: state.courses.map((e) => GestureDetector(
                                    child: Container(
                                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AspectRatio(
                                                aspectRatio: 16/9,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(4.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl: e.image,
                                                    placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                                                    errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
                                                  ),
                                                )),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                                              child: Text(
                                                e.name,
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
                                          ],
                                        )
                                    ),
                                    onTap: () {
                                      context.bloc<CourseInfoCubit>().initial(e.id, state.avatar, state.balls);
                                      Navigator.pushNamed(context, courseInfoRoute);
                                    },
                                  )).toList(),
                                ),
                              )
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverGrid(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                                childAspectRatio: 8.0 / 10.0,
                              ),
                              delegate: SliverChildListDelegate(
                                [
                                  for (var product in state.products) if(int.parse(product.cost_balls) <= int.parse(state.balls)) Container(
                                    padding: EdgeInsets.all(5.0),
                                    color: Color.fromARGB(255, 243, 246, 251),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(flex: 3, child: ClipRRect(
                                          borderRadius: BorderRadius.circular(4.0),
                                          child: CachedNetworkImage(
                                            imageUrl: product.image,
                                            placeholder: (context, url) => Container(),
                                            errorWidget: (context, url, error) => Container(),
                                          ),
                                        ),),
                                        Expanded(flex: 1, child: Container(
                                          child: Text(
                                            product.name,
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),),
                                        Expanded(flex: 1, child: Container(
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            product.cost_balls + " баллов",
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 13,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),),
                                        Expanded(flex: 1, child: Container(
                                            padding: EdgeInsets.only(top: 10.0),
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
                                                        fontFamily: 'Segoe UI',
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                      onPressed: () {
                                                        context.bloc<ShopCubit>().buyProduct(product.id, context);
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                ));
                                              },
                                            )
                                        ),)
                                      ],
                                    ),
                                  ),
                                  for (var product in state.products) if(int.parse(product.cost_balls) > int.parse(state.balls)) Container(
                                    padding: EdgeInsets.all(5.0),
                                    color: Color.fromARGB(255, 211, 221, 233),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(flex: 3, child: ClipRRect(
                                          borderRadius: BorderRadius.circular(4.0),
                                          child: CachedNetworkImage(
                                            imageUrl: product.image,
                                            placeholder: (context, url) => Container(),
                                            errorWidget: (context, url, error) => Container(),
                                          ),
                                        ),),
                                        Expanded(flex: 1, child: Container(
                                          child: Text(
                                            product.name,
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),),
                                        Expanded(flex: 1, child: Container(
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            product.cost_balls + " баллов",
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 13,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),),
                                        Expanded(flex: 1, child: Container(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: GestureDetector(
                                              child: Text(
                                                "Мало баллов",
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontFamily: 'Segoe UI',
                                                  fontSize: 13,
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              onTap: null,
                                            )
                                        ),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: SizedBox(
                                height: double.infinity,
                                child: Image.asset('assets/images/promo.png'),
                              ),
                            ),
                            Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 44,
                                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                      child: TextField(
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 16,
                                        ),
                                        controller: promoController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10.0),
                                          labelText: "Введите промокод",
                                          labelStyle: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'Segoe UI',
                                            fontSize: 14,
                                          ),
                                          hintStyle: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'Segoe UI',
                                            fontSize: 16,
                                          ),
                                          prefixStyle: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'Segoe UI',
                                            fontSize: 16,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black12, width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black12, width: 1.0),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(0.0))
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height: 38,
                                        margin: EdgeInsets.all(10.0),
                                        child: FlatButton(
                                          textColor: Colors.white,
                                          color: Colors.blue,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Отправить',
                                                style: TextStyle(
                                                  fontFamily: 'Segoe UI',
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            if (promoController.text.length > 0) {
                                              context.bloc<ShopCubit>().sendPromocode(promoController.text);
                                              context.bloc<CoursesPromoCubit>().initial(context, promoController.text, state.balls, state.avatar);
                                              Navigator.pushNamed(context, coursePromoRoute);
                                            }
                                          },
                                        )),
                                  ],
                                )
                            )
                          ],
                        ),
                      )
                    ],
                  )
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
        )
    );
  }
}