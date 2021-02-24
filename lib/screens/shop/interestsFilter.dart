import 'package:flutter/material.dart';
import 'package:isbusiness/cubit/shop/shopcubit.dart';
import 'package:isbusiness/data/course/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/data/product/product.dart';

class Interests extends StatefulWidget {
  List<int> interestsInt;
  Map<int, String> interests;
  String balls;
  String avatar;
  int free;
  List<Product> products;

  Interests(this.interestsInt, this.interests, this.balls, this.avatar, this.products, this.free);

  @override
  State<StatefulWidget> createState() {
    return InterestsState(interestsInt, this.interests, balls, avatar, products, free);
  }

}

class InterestsState extends State<Interests> {
  List<int> interestsInt;
  Map<int, String> interests;
  String balls;
  String avatar;
  int free;
  List<Product> products;

  InterestsState(this.interestsInt, this.interests, this.balls, this.avatar, this.products, this.free);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Интересы",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Segoe UI',
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            )
        ),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int value in interests.keys) ListTile(
                        title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(flex: 1, child: Checkbox(
                                value: interestsInt.contains(value),
                                onChanged: (bool valueBool) {
                                  valueBool ? interestsInt.add(value) : interestsInt.remove(value);
                                  setState(() {

                                  });
                                },
                              ),),
                              Flexible(flex:5, child: Text(
                                interests[value],
                                style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 12,
                                    color: Colors.black),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),)
                            ]
                        ),
                        onTap: () {
                          !interestsInt.contains(value) ? interestsInt.add(value) : interestsInt.remove(value);
                          setState(() {

                          });
                        },
                      )
                    ],
                  ),
                )
            ),
            Container(
                height: 38,
                color: Colors.black38,
                margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
                child: FlatButton(
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
                    context.bloc<ShopCubit>().change(balls, products, avatar, interestsInt, free);
                    Navigator.pop(context);
                  },
                )),
          ],
        )
    );
  }
}