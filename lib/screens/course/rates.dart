import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/cubit/courseinfo/courseinfocubit.dart';
import 'package:isbusiness/data/rates/rates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatesScreen extends StatelessWidget {
  List<Rate> rates;
  String avatar;
  String balls;

  RatesScreen(this.rates, this.avatar, this.balls);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            children: [
              Expanded(flex: 7, child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                      balls + "Б",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Segoe UI',
                        fontSize: 16,
                        //fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right
                  )),),
              if (avatar == null) Expanded(flex: 1, child: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.black12,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image(image: AssetImage("assets/images/user.png")),
                ),
              ),),
              if (avatar != null) Expanded(flex: 1, child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: avatar,
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
              ),),
            ],
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
              width: double.infinity,
              child: Text(
                "Выберете тарифный план",
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            for (var rate in rates) Container(
              margin: EdgeInsets.all(10.0),
              color: Color.fromARGB(200, 209, 221, 234),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      rate.title,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 22,
                          fontWeight: FontWeight.w700
                      ),
                      textAlign: TextAlign.left,
                    ),
                    margin: EdgeInsets.all(10.0),
                  ),
                  if (rate.description.length > 0) Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      rate.description,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 16,
                          color: Colors.black
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    child: Text(
                      rate.price + " ₽",
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                          color: Colors.indigoAccent,
                          fontWeight: FontWeight.w700
                      ),
                      textAlign: TextAlign.left,
                    ),
                    margin: EdgeInsets.all(10.0),
                  ),
                  if (rate.pros.length > 0) for (var pros in rate.pros.split('|')) ListTile(
                    leading: Icon(Icons.check, color: Colors.indigoAccent),
                    title: Text(
                      pros,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 16
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  if (rate.cons.length > 0) for (var cons in rate.cons.split('|')) ListTile(
                    leading: Icon(Icons.close, color: Colors.black54),
                    title: Text(
                      cons,
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 16,
                          color: Colors.black54
                      ),
                      textAlign: TextAlign.left,
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
                              'Купить доступ',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          context.bloc<CourseInfoCubit>().buyCourse(context, rate.id_course, rate.id);
                        },
                      )),
                ],
              ),
            )
          ],
        )
    );
  }
}