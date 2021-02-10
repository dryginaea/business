import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/cubit/courseinfo/courseinfocubit.dart';
import 'package:isbusiness/cubit/eventinfo/eventinfocubit.dart';
import 'package:isbusiness/cubit/home/homecubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/home/homestate.dart';
import 'package:isbusiness/cubit/menu/menucubit.dart';
import 'package:isbusiness/cubit/menu/menustate.dart';
import 'package:isbusiness/cubit/projectinfo/projectinfocubit.dart';
import 'package:isbusiness/router/router.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
   return BlocBuilder<HomeCubit, HomeState>(
     builder: (context, state) {
       if (state is InitialHomeState) {
         context.bloc<HomeCubit>().initial();
       }

       if (state is LoadedHomeState) {
         return Scaffold(
           backgroundColor: Colors.white,
           appBar: AppBar(
             elevation: 0.0,
             title: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Expanded(flex: 4, child: Image.asset('assets/images/logo.png')),
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
           body: ListView(
             children: [
               Padding(
                 padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                 child: Text(
                   "Афиша",
                   style: TextStyle(
                     fontFamily: 'Segoe UI',
                     fontSize: 22,
                     fontWeight: FontWeight.w600,
                   ),
                   textAlign: TextAlign.left,
                 ),
               ),
               if (state.projects.length == 0) GestureDetector(
                 child: Container(
                   height: 250,
                   child: Image.asset("assets/images/projectsnull.png"),
                 ),
                 onTap: () => context.bloc<MenuCubit>().emit(InitialMenuState(2)),
               ),
               if (state.projects.length == 1) GestureDetector(
                   child: Container(
                     padding: EdgeInsets.all(10.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         AspectRatio(
                             aspectRatio: 16/9,
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(4.0),
                               child: CachedNetworkImage(
                                 imageUrl: state.projects.first.image,
                                 placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                                 errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
                               ),
                             )),
                         Container(
                           padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                           child: Text(
                             state.projects.first.name,
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
                         Text(
                           state.projects.first.dateTime,
                           style: TextStyle(
                               fontFamily: 'Segoe UI',
                               fontSize: 16,
                               color: Colors.black54
                             //fontWeight: FontWeight.w700,
                           ),
                           textAlign: TextAlign.left,
                         ),
                       ],
                     ),
                   ),
                   onTap: () {
                     context.bloc<ProjectInfoCubit>().initial(state.projects.first.id, state.projects.first.events, state.avatar, state.balls);
                     Navigator.pushNamed(context, projectInfoRoute);
                   }
               ),
               if (state.projects.length > 1) Container(
                 height: 250,
                 child: ListView(
                   scrollDirection: Axis.horizontal,
                   children: [
                     Container(
                       padding: EdgeInsets.only(right: 10.0),
                     ),
                     for (var project in state.projects) GestureDetector(
                       child: Container(
                         padding: EdgeInsets.only(right: 10.0),
                         width: 300,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             AspectRatio(
                               aspectRatio: 16/9,
                               child: ClipRRect(
                                 borderRadius: BorderRadius.circular(4.0),
                                 child: CachedNetworkImage(
                                   imageUrl: project.image,
                                   placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                                   errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
                                 ),
                               )),
                             Container(
                               padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                               child: Text(
                                 project.name,
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
                             Text(
                               project.dateTime,
                               style: TextStyle(
                                   fontFamily: 'Segoe UI',
                                   fontSize: 16,
                                   color: Colors.black54
                                 //fontWeight: FontWeight.w700,
                               ),
                               textAlign: TextAlign.left,
                             ),
                           ],
                         ),
                       ),
                       onTap: () {
                         context.bloc<ProjectInfoCubit>().initial(project.id, project.events, state.avatar, state.balls);
                         Navigator.pushNamed(context, projectInfoRoute);
                       }
                     )
                   ]
                 ),
               ),
               if (state.projects.length > 0) Container(
                   height: 38,
                   margin: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 30.0),
                   child: FlatButton(
                     textColor: Colors.indigoAccent,
                     shape: RoundedRectangleBorder(side: BorderSide(
                         color: Colors.indigoAccent,
                     )),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           'Смотреть все',
                           style: TextStyle(
                             fontFamily: 'Segoe UI',
                             fontSize: 14,
                           ),
                         ),
                       ],
                     ),
                     onPressed: () => context.bloc<MenuCubit>().emit(InitialMenuState(1))
                   )),
               Padding(
                 padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                 child: Text(
                   "Мои мероприятия",
                   style: TextStyle(
                     fontFamily: 'Segoe UI',
                     fontSize: 22,
                     fontWeight: FontWeight.w600,
                   ),
                   textAlign: TextAlign.left,
                 ),
               ),
               if (state.myProjects.length == 0) GestureDetector(
                 child: Container(
                   height: 250,
                   child: Container(
                     height: 250,
                     child: Image.asset("assets/images/myprojectsnull.png"),
                   ),
                 ),
                 onTap: () => Navigator.pushNamed(context, pastEventsRoute),
               ),
               if (state.myProjects.length == 1) GestureDetector(
                   onTap: () {
                     context.bloc<EventInfoCubit>().initial(state.myProjects.first.id, state.myProjects.first.dateDay, state.myProjects.first.location, state.avatar, state.balls);
                     Navigator.pushNamed(context, eventInfoRoute);
                   },
                   child: Container(
                     padding: EdgeInsets.all(10.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Stack(
                           children: [
                             AspectRatio(
                                 aspectRatio: 16/9,
                                 child: ClipRRect(
                                   borderRadius: BorderRadius.circular(4.0),
                                   child: CachedNetworkImage(
                                     imageUrl: state.myProjects.first.image,
                                     placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                                     errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
                                   ),
                                 )),
                             if (state.myProjects.first.isOnline) Align(alignment: Alignment.topRight, child: Container(
                               padding: EdgeInsets.all(5.0),
                               margin: EdgeInsets.all(10.0),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(15.0),
                                   color: Colors.red
                               ),
                               child: Text(
                                 " в эфире ",
                                 style: TextStyle(
                                     fontFamily: 'Segoe UI',
                                     fontSize: 12,
                                     color: Colors.white
                                   //fontWeight: FontWeight.w700,
                                 ),
                               ),
                             )),
                             if (int.parse(state.myProjects.first.cost_balls) > 0) Container(
                               padding: EdgeInsets.all(5.0),
                               margin: EdgeInsets.all(10.0),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(15.0),
                                   color: Colors.amberAccent
                               ),
                               child: Text(
                                 "- " + state.myProjects.first.cost_balls + " баллов",
                                 style: TextStyle(
                                   fontFamily: 'Segoe UI',
                                   fontSize: 12,
                                   //fontWeight: FontWeight.w700,
                                 ),
                               ),
                             ),
                             if (int.parse(state.myProjects.first.give_balls) > 0) Container(
                               padding: EdgeInsets.all(5.0),
                               margin: EdgeInsets.all(10.0),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(15.0),
                                   color: Colors.amberAccent
                               ),
                               child: Text(
                                 "+ " + state.myProjects.first.give_balls + " баллов",
                                 style: TextStyle(
                                   fontFamily: 'Segoe UI',
                                   fontSize: 12,
                                   //fontWeight: FontWeight.w700,
                                 ),
                               ),
                             ),
                           ],
                         ),
                         Container(
                           padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                           child: Text(
                             state.myProjects.first.name,
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
                         Text(
                           state.myProjects.first.dateDay,
                           style: TextStyle(
                               fontFamily: 'Segoe UI',
                               fontSize: 16,
                               color: Colors.black54
                             //fontWeight: FontWeight.w700,
                           ),
                           textAlign: TextAlign.left,
                         ),
                       ],
                     ),
                   )
               ),
               if (state.myProjects.length > 1) Container(
                 height: 250,
                 child: ListView(
                     scrollDirection: Axis.horizontal,
                     children: [
                       Container(
                         padding: EdgeInsets.only(right: 10.0),
                       ),
                       for (var project in state.myProjects) GestureDetector(
                         onTap: () {
                           context.bloc<EventInfoCubit>().initial(project.id, project.dateDay, project.location, state.avatar, state.balls);
                           Navigator.pushNamed(context, eventInfoRoute);
                         },
                         child: Container(
                           padding: EdgeInsets.only(right: 10.0),
                           width: 300,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Stack(
                                 children: [
                                   AspectRatio(
                                       aspectRatio: 16/9,
                                       child: ClipRRect(
                                         borderRadius: BorderRadius.circular(4.0),
                                         child: CachedNetworkImage(
                                           imageUrl: project.image,
                                           placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                                           errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
                                         ),
                                       )),
                                   if (project.isOnline) Align(alignment: Alignment.topRight, child: Container(
                                     padding: EdgeInsets.all(5.0),
                                     margin: EdgeInsets.all(10.0),
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(15.0),
                                         color: Colors.red
                                     ),
                                     child: Text(
                                       " в эфире ",
                                       style: TextStyle(
                                           fontFamily: 'Segoe UI',
                                           fontSize: 12,
                                           color: Colors.white
                                         //fontWeight: FontWeight.w700,
                                       ),
                                     ),
                                   )),
                                   if (int.parse(project.cost_balls) > 0) Container(
                                     padding: EdgeInsets.all(5.0),
                                     margin: EdgeInsets.all(10.0),
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(15.0),
                                         color: Colors.amberAccent
                                     ),
                                     child: Text(
                                       "- " + project.cost_balls + " баллов",
                                       style: TextStyle(
                                         fontFamily: 'Segoe UI',
                                         fontSize: 12,
                                         //fontWeight: FontWeight.w700,
                                       ),
                                     ),
                                   ),
                                   if (int.parse(project.give_balls) > 0) Container(
                                     padding: EdgeInsets.all(5.0),
                                     margin: EdgeInsets.all(10.0),
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(15.0),
                                         color: Colors.amberAccent
                                     ),
                                     child: Text(
                                       "+ " + project.give_balls + " баллов",
                                       style: TextStyle(
                                         fontFamily: 'Segoe UI',
                                         fontSize: 12,
                                         //fontWeight: FontWeight.w700,
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                               Container(
                                 padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                                 child: Text(
                                   project.name,
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
                               Text(
                                 project.dateDay,
                                 style: TextStyle(
                                     fontFamily: 'Segoe UI',
                                     fontSize: 16,
                                     color: Colors.black54
                                   //fontWeight: FontWeight.w700,
                                 ),
                                 textAlign: TextAlign.left,
                               ),
                             ],
                           ),
                         )
                       )
                     ]
                 ),
               ),
               Container(
                 padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                 child: Text(
                   "Курсы",
                   style: TextStyle(
                     fontFamily: 'Segoe UI',
                     fontSize: 22,
                     fontWeight: FontWeight.w600,
                   ),
                   textAlign: TextAlign.left,
                 ),
               ),
               if (state.courses.length == 0) Container(
                 height: 230,
                 alignment: Alignment.center,
                 child: Text(
                   "Курсов пока нет",
                   style: TextStyle(
                     fontFamily: 'Segoe UI',
                     color: Colors.black45,
                     fontSize: 16,
                     fontWeight: FontWeight.w500,
                   ),
                   textAlign: TextAlign.left,
                 ),
               ),
               if (state.courses.length == 1) GestureDetector(
                   child: Container(
                     padding: EdgeInsets.all(10.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         AspectRatio(
                             aspectRatio: 16/9,
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(4.0),
                               child: CachedNetworkImage(
                                 imageUrl: state.courses.first.image,
                                 placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                                 errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
                               ),
                             )),
                         Container(
                           padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                           child: Text(
                             state.courses.first.name,
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
                     ),
                   ),
                   onTap: () {
                     context.bloc<CourseInfoCubit>().initial(state.courses.first.id, state.avatar, state.balls);
                     Navigator.pushNamed(context, courseInfoRoute);
                   }
               ),
               if (state.courses.length > 1) Container(
                 height: 250,
                 child: ListView(
                     scrollDirection: Axis.horizontal,
                     children: [
                       Container(
                         padding: EdgeInsets.only(right: 10.0),
                       ),
                       for (var course in state.courses) GestureDetector(
                           child: Container(
                             padding: EdgeInsets.only(right: 10.0),
                             width: 300,
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 AspectRatio(
                                     aspectRatio: 16/9,
                                     child: ClipRRect(
                                       borderRadius: BorderRadius.circular(4.0),
                                       child: CachedNetworkImage(
                                         imageUrl: course.image,
                                         placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                                         errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
                                       ),
                                     )),
                                 Container(
                                   padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                                   child: Text(
                                     course.name,
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
                             ),
                           ),
                           onTap: () {
                             context.bloc<CourseInfoCubit>().initial(course.id, state.avatar, state.balls);
                             Navigator.pushNamed(context, courseInfoRoute);
                           }
                       )
                     ]
                 ),
               ),
               Padding(
                 padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                 child: Text(
                   "Полезные мероприятия",
                   style: TextStyle(
                     fontFamily: 'Segoe UI',
                     fontSize: 22,
                     fontWeight: FontWeight.w600,
                   ),
                   textAlign: TextAlign.left,
                 ),
               ),
               Container(
                 height: 150,
                 margin: EdgeInsets.only(bottom: 30.0),
                 child: ListView(
                     scrollDirection: Axis.horizontal,
                     children: [
                       Container(
                         padding: EdgeInsets.only(right: 10.0),
                       ),
                       for (var project in state.partnerProjects) Container(
                         padding: EdgeInsets.only(right: 10.0),
                         width: 250,
                         child: Stack(
                           children: [
                             GestureDetector(
                               onTap: () => _launchURL(project.url),
                               child: AspectRatio(
                                   aspectRatio: 16/9,
                                   child: ClipRRect(
                                     borderRadius: BorderRadius.circular(4.0),
                                     child: CachedNetworkImage(
                                       imageUrl: project.image,
                                       placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                                       errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
                                     ),
                                   )),
                             ),
                             Container(
                               padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
                               alignment: Alignment.bottomLeft,
                               child:  Text(
                                 project.name,
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontFamily: 'Segoe UI',
                                   fontSize: 12,
                                   fontWeight: FontWeight.w700,
                                 ),
                                 textAlign: TextAlign.left,
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                               ),
                             )
                           ],
                         ),
                       )
                     ]
                 ),
               ),
             ],
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