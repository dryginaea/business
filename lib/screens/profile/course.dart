import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/cubit/courseinfo/courseinfocubit.dart';
import 'package:isbusiness/data/course/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/router/router.dart';

class MyCourseList extends StatelessWidget {
  List<Course> courses;
  String avatar;
  String balls;

  MyCourseList(this.courses, this.avatar, this.balls);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Мои курсы",
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          )
      ),
      body: ListView.builder(
          itemBuilder: (context, i) {
            return GestureDetector(
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
                              imageUrl: courses[i].image,
                              placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                              errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                        child: Text(
                          courses[i].name,
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
                context.bloc<CourseInfoCubit>().initial(courses[i].id, avatar, balls);
                Navigator.pushNamed(context, courseInfoRoute);
              },
            );
          },
        itemCount: courses.length,
      )
    );
  }
}