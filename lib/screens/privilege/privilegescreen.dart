import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/privilege/privilegecubit.dart';
import 'package:isbusiness/cubit/privilege/privilegestate.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivilegeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Привилегии",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Segoe UI',
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        body: BlocBuilder<PrivilegeCubit, PrivilegeState>(
          builder: (context, state) {
            if (state is InitialPrivilegeState) {
              context.bloc<PrivilegeCubit>().initial();
            }

            if (state is LoadedPrivilegeState) {
              return ListView(
                children: state.privilege.map((privilege) => Container(
                  padding: EdgeInsets.all(5.0),
                  color: Colors.white,
                  height: 160,
                  child: Row(
                    children: [
                      Expanded(flex: 3, child: Container(child: CachedNetworkImage(
                        imageUrl: privilege.image,
                        placeholder: (context, url) => Container(),
                        errorWidget: (context, url, error) => Container(),
                      ),)),
                      Expanded(flex: 4, child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0), child: Text(
                            privilege.name,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),),
                          Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0), child: Text(
                            privilege.short_description,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          )),
                          Padding(padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0), child: GestureDetector(
                            child: Text(
                              "Подробнее",
                              style: TextStyle(
                                color: Colors.indigoAccent,
                                fontFamily: 'Segoe UI',
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () => context.bloc<PrivilegeCubit>().dialog(privilege, context),
                          ))
                        ],
                      )),
                    ],
                  ),
                )).toList()
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        )
    );
  }
}