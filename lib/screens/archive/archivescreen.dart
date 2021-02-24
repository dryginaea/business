import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/archive/archivecubit.dart';
import 'package:isbusiness/cubit/archive/archivestate.dart';
import 'package:isbusiness/cubit/eventpastinfo/eventpastinfocubit.dart';
import 'package:isbusiness/cubit/menu/menucubit.dart';
import 'package:isbusiness/cubit/menu/menustate.dart';
import 'package:isbusiness/router/router.dart';

class ArchiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArchiveCubit, ArchiveState>(
        builder: (context, state) {
          if (state is InitialArchiveState) {
            context.bloc<ArchiveCubit>().initial();
          }

          if (state is LoadedArchiveState) {
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
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
                body: ListView.builder(
                  controller: state.scrollController,
                  itemBuilder: (context, i) {
                    if (i == 0) return Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                      child: Text(
                        "Архив",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Segoe UI',
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    );

                    if (i == state.projects.length + 1) return ListTile(
                      title: Center(
                        child: SizedBox(
                          height: 25.0,
                          width: 25.0,
                          child: CircularProgressIndicator(),
                        )
                      )
                    );

                    return GestureDetector(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                                aspectRatio: 16/9,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: CachedNetworkImage(
                                    imageUrl: state.projects[i - 1].image,
                                    placeholder: (context, url) => Image(image: AssetImage("assets/images/img.png")),
                                    errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/img.png")),
                                  ),
                                )),
                            Container(
                              padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                              child: Text(
                                state.projects[i - 1].name,
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
                              state.projects[i - 1].dateTime,
                              style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 16,
                                  color: Colors.black54
                                //fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      onTap: () {
                        context.bloc<EventPastInfoCubit>().initial(state.projects[i - 1].id, state.projects[i].dateTime, "");
                        Navigator.pushNamed(context, pastEventRoute);
                      },
                    );
                  },
                  itemCount: state.projects.length + 2,
                )
            );
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
    );
  }
}
