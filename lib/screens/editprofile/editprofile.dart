import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:isbusiness/cubit/events/eventscubit.dart';
import 'package:isbusiness/cubit/home/homecubit.dart';
import 'package:isbusiness/cubit/profile/profilecubit.dart';
import 'package:isbusiness/cubit/shop/shopcubit.dart';
import 'package:isbusiness/router/router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatefulWidget {
  final String avatar;
  final String surname;
  final String name;
  final String last_name;
  final String email;
  final String phone;
  final bool type;
  final Map<String, bool> interests;
  BuildContext context_profile;

  EditProfile(this.avatar, this.surname, this.name, this.last_name, this.interests, this.email, this.phone, this.type, this.context_profile);

  @override
  State<StatefulWidget> createState() => EditProfileState(avatar, surname, name, last_name, interests, email, phone, type, context_profile);

}

class EditProfileState extends State<EditProfile> {
  final String avatar;
  String surname;
  String name;
  String last_name;
  final String email;
  final String phone;
  final bool type;
  final Map<String, bool> interests;
  BuildContext context_profile;

  EditProfileState(this.avatar, this.surname, this.name, this.last_name, this.interests, this.email, this.phone, this.type, this.context_profile);

  File _image;

  @override
  Widget build(BuildContext context) {
    var _surname = TextEditingController(text: surname);
    var _name = TextEditingController(text: name);
    var _lastName = TextEditingController(text: last_name);
    ApiService apiService = Provider.of(context);

    _imgFromCamera() async {
      File image = await ImagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 50
      );

      setState(() {
        name = _name.text;
        surname = _surname.text;
        last_name = _lastName.text;
        _image = image;
      });
    }

    _imgFromGallery() async {
      File image = await  ImagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50
      );

      setState(() {
        name = _name.text;
        surname = _surname.text;
        last_name = _lastName.text;
        _image = image;
      });
    }
    void _showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text('Выбрать из галереи'),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text('Сфотографировать'),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          }
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Профиль",
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
          actions: [
            IconButton(
                icon: Container(padding: EdgeInsets.all(10.0),child: Image.asset("assets/images/settings.png")),
                onPressed: () => Navigator.pushNamed(context, settingsRoute)
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_image != null) CircleAvatar(
                              radius: 50.0,
                              backgroundImage: FileImage(_image),
                            ),
                            if (_image == null && avatar == null) CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.black12,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image(image: AssetImage("assets/images/user.png")),
                              ),
                            ),
                            if (_image == null && avatar != null) CachedNetworkImage(
                              fit: BoxFit.contain,
                              imageUrl: avatar,
                              imageBuilder: (context, imageProvider) => Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) => CircleAvatar(
                                radius: 50.0,
                                backgroundColor: Colors.black12,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Image(image: AssetImage("assets/images/user.png")),
                                ),
                              ),
                              errorWidget: (context, url, error) => CircleAvatar(
                                radius: 50.0,
                                backgroundColor: Colors.black12,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Image(image: AssetImage("assets/images/user.png")),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: FlatButton(
                            onPressed: () {
                              _showPicker(context);
                            },
                            child: Text(
                              "Сменить фото",
                              style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 12,
                                  color: Colors.blueAccent
                              ),
                            )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: Text(
                          "Фамилия",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: TextField(
                          cursorColor: Colors.indigo,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                          controller: _surname,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black45, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(0.0))
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: Text(
                          "Имя",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: TextField(
                          cursorColor: Colors.indigo,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                          controller: _name,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black45, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(0.0))
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: Text(
                          "Отчество",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: TextField(
                          cursorColor: Colors.indigo,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                          controller: _lastName,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black45, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(0.0))
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: Text(
                          "Область интересов",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["1"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["1"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["1"] = !interests["1"];
                          }),
                          title: Text(
                            "Производство",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["2"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["2"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["2"] = !interests["2"];
                          }),
                          title: Text(
                            "Продажи",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["3"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["3"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["3"] = !interests["3"];
                          }),
                          title: Text(
                            "Экспорт/Импорт",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["4"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["4"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["4"] = !interests["4"];
                          }),
                          title: Text(
                            "Услуги",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["5"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["5"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["5"] = !interests["5"];
                          }),
                          title: Text(
                            "IT-Технологии",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["6"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["6"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["6"] = !interests["6"];
                          }),
                          title: Text(
                            "Фермерство",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["7"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["7"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["7"] = !interests["7"];
                          }),
                          title: Text(
                            "Сельское хозяйство",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["8"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["8"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["8"] = !interests["8"];
                          }),
                          title: Text(
                            "Женский бизнес",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                        child: Text(
                          "Темы обучения",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["16"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["16"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["16"] = !interests["16"];
                          }),
                          title: Text(
                            "Аудит и постороение бизнес-процессов",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["17"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["17"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["17"] = !interests["17"];
                          }),
                          title: Text(
                            "Переговоры и продажи",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["18"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["18"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["18"] = !interests["18"];
                          }),
                          title: Text(
                            "Маркетинг",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["19"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["19"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["19"] = !interests["19"];
                          }),
                          title: Text(
                            "Командообразование и развитие персонала",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["20"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["20"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["20"] = !interests["20"];
                          }),
                          title: Text(
                            "Бухгалтерия и финансовый учёт",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["21"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["21"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["21"] = !interests["21"];
                          }),
                          title: Text(
                            "Управленческий учёт",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["22"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["22"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["22"] = !interests["22"];
                          }),
                          title: Text(
                            "Личная эффективность",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["23"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["23"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["23"] = !interests["23"];
                          }),
                          title: Text(
                            "Франчайзинг",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["24"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["24"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["24"] = !interests["24"];
                          }),
                          title: Text(
                            "Продажи на маркетплейсах",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.blueAccent,
                            value: interests["25"],
                            onChanged: (bool value) {
                              setState(() {
                                name = _name.text;
                                surname = _surname.text;
                                last_name = _lastName.text;
                                interests["25"] = value;
                              });
                            },
                          ),
                          onTap: () => setState(() {
                            name = _name.text;
                            surname = _surname.text;
                            last_name = _lastName.text;
                            interests["25"] = !interests["25"];
                          }),
                          title: Text(
                            "Интересны все темы по развитию предпринимательских компетенций",
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                        child: Text(
                          "Почта",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: double.infinity,
                        //height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(
                              Radius.circular(5.0)
                          ),
                          color: Colors.black12
                        ),
                        child: Text(
                          email,
                          style: TextStyle(
                            color: Colors.black45,
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: Text(
                          "Телефон",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: double.infinity,
                        //height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0)
                            ),
                            color: Colors.black12
                        ),
                        child: Text(
                          phone,
                          style: TextStyle(
                            color: Colors.black45,
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: Text(
                          "Вы предприниматель?",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Flexible(flex: 1, child: Row(
                              children: [
                                Checkbox(value: type, onChanged: null),
                                Text(
                                  "Да",
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 14,
                                    color: Colors.black54
                                  ),
                                ),
                              ],
                            )),
                            Flexible(flex: 1, child: Row(
                              children: [
                                Checkbox(value: !type, onChanged: null),
                                Text(
                                  "Нет",
                                  style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 14,
                                      color: Colors.black54
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
                        child: Text(
                          "Для изменения данных пунктов вам необходимо обратиться в службу поддержки",
                          style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 13,
                              color: Colors.black54
                          ),
                        ),
                      ),
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
                        'Сохранить и выйти',
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async{
                    var list = List<int>();
                    for(var e in interests.keys) {
                      if (interests[e]) list.add(int.parse(e));
                    }
                    var data = {
                      "id_region": "13",
                      "city": "",
                      "name": _name.text,
                      "surname": _surname.text,
                      "last_name": _lastName.text,
                      "interests": list
                    };

                    try{
                      showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                      ),));
                      await apiService.setInfo(data);
                      if (_image != null) {
                        await apiService.updateAvatar(_image);
                        context.bloc<HomeCubit>().initial();
                        context.bloc<ShopCubit>().initial();
                        context.bloc<EventsCubit>().initial();
                      }

                      context.bloc<ProfileCubit>().initial();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } catch (e) {
                      context.bloc<ProfileCubit>().showEditError(context_profile);
                    }

                  },
                )),
          ],
        )
    );
  }
}