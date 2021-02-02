import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/courseinfo/courseinfocubit.dart';
import 'package:isbusiness/cubit/coursespromo/coursespromocubit.dart';
import 'package:isbusiness/cubit/coursespromo/coursespromostate.dart';
import 'package:isbusiness/router/router.dart';

class CoursesPromo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesPromoCubit, CoursesPromoState>(builder: (context, state) {
      if (state is LoadedCoursesPromoState) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0.0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 4, child: Container()),
                  Expanded(flex: 3, child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                          state.balls + "Б",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                            //fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.right
                      )),),
                  if (state.avatar == null) Expanded(flex: 1, child: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.black12,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image(image: AssetImage("assets/images/user.png")),
                    ),
                  ),),
                  if (state.avatar != null) Expanded(flex: 1, child: CachedNetworkImage(
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
                  ),),
                ],
              ),
            ),
            body: ListView(
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
    });
  }
}