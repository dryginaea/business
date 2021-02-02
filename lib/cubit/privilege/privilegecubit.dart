import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:isbusiness/cubit/privilege/privilegestate.dart';
import 'package:isbusiness/data/privilege/privilege.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivilegeCubit extends Cubit<PrivilegeState> {
  PrivilegeCubit(this.apiService) : super(InitialPrivilegeState());

  ApiService apiService;

  void initial() async{
    emit(LoadingPrivilegeState());
    try {
      var privilege = await apiService.getPrivilege();
      emit(LoadedPrivilegeState(privilege.privilegelist));
    } catch (e) {
      emit(ErrorPrivilegeState());
    }
  }

  void dialog(Privilege privilege, BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Container(
        height: 200,
        color: Color.fromARGB(255, 243, 246, 251),
        padding: EdgeInsets.all(5.0),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: CachedNetworkImage(
                imageUrl: privilege.image,
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => Container(),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              child: IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            )
          ],
        ),
      ),
      titlePadding: EdgeInsets.all(0.0),
      contentPadding: EdgeInsets.all(10.0),
      content:  Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              privilege.name,
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            Padding(padding: EdgeInsets.only(top: 10.0), child: Text(
              privilege.description,
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
            )),
            if(!privilege.is_registered) Container(
              margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              width: double.infinity,
              height: 38,
              color: Colors.blueAccent,
              child: FlatButton(
                  child: Text(
                    'Активировать',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Segoe UI',
                      fontSize: 12,
                    ),
                  ),
                onPressed: () async{
                  Navigator.pop(context);
                  var check = await apiService.registrationForPrivilege(privilege.id);
                  initial();
                  if (check) showDialog(context: context, builder: (context) => AlertDialog(
                    content: Text(
                      "Вы успешно активировали привилегию.",
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
                        },
                      )
                    ],
                  ));
                  if (!check) showDialog(context: context, builder: (context) => AlertDialog(
                    content: Text(
                      "Ошибка. Повторите попытку.",
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
                        },
                      )
                    ],
                  ));
                },
              ),
            ),
            if(privilege.is_registered) Container(
              margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              width: double.infinity,
              height: 38,
              color: Colors.black38,
              child: FlatButton(
                child: Text(
                  'Активировано',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Segoe UI',
                    fontSize: 12,
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    ));
  }
}