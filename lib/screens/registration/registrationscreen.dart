import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:isbusiness/cubit/cityList/cityListCubit.dart';
import 'package:isbusiness/cubit/cityList/cityListState.dart';
import 'package:isbusiness/cubit/companyInn/companyInnCubit.dart';
import 'package:isbusiness/cubit/companyInn/companyInnState.dart';
import 'package:isbusiness/cubit/registration/registrationcubit.dart';
import 'package:isbusiness/cubit/registration/registrationstate.dart';
import 'package:isbusiness/router/router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationScreen extends StatelessWidget{
  var isSelected = [false, false];
  @override
  Widget build(BuildContext context) {
    context.bloc<RegistrationCubit>().emit(InitialState());
    context.bloc<CompanyInnCubit>().initial("");
    context.bloc<CityListCubit>().initial("");
    var inn = TextEditingController();
    var surname = TextEditingController();
    var name = TextEditingController();
    var lastname = TextEditingController();
    var phone = TextEditingController();
    var email = TextEditingController();
    var datebirthday = TextEditingController();
    var region = TextEditingController();
    var city = TextEditingController();
    var code = TextEditingController();

    var textFieldPhone = new FocusNode();

    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pushNamed(context, loginRoute),
            ),
            title: Text(
              "Регистрация",
              style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),
              textAlign: TextAlign.left,
            ),
        ),
      body: BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
          print(state);
          if (state is LoadingState) return Center(child: CircularProgressIndicator());
          if (state is InitialState) isSelected = [false, false];
          return ListView(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                color: Color.fromARGB(255, 231, 235, 243),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Заполните анкету",
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Дорогой друг!",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left,
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Предпринимательство – это не просто деятельность, заключающаяся в систематическом получении прибыли на свой страх и риск. Это образ жизни, связанный со способностью человека брать на себя ответственность за собственную жизнь, семью, близкое окружение, команду.",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left,
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Заполнив анкету, вы:",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(
                          "\u2022 получите самую свежую и актуальную информацию для эффективного ведения бизнеса и развития предпринимательских компетенций;",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left,
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 10.0),
                        child: Text(
                          "\u2022 станете членом сообщества предпринимателей, которые развиваются и выстраивают ценные связи, ищут новые возможности и реализуют их.",
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left,
                        )
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1. Зарегистрированы ли вы в качестве индивидуального предпринимателя, юридического лица или самозанятого?",
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          fontWeight: FontWeight.w700
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: ToggleButtons(
                            borderRadius: BorderRadius.circular(2.0),
                            constraints: BoxConstraints(
                                maxHeight: 30.0,
                                minHeight: 30.0,
                                minWidth: 60.0,
                                maxWidth: 60.0
                            ),
                            children: <Widget>[
                              Text(
                                "Да",
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Нет",
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                            onPressed: (int index) {
                              if (state is YesAgreeState || state is NoAgreeState) {
                                if (index == 0) {
                                  isSelected = [true, false];
                                  context.bloc<RegistrationCubit>().emit(YesAgreeState());
                                }
                                if (index == 1) {
                                  isSelected = [false, true];
                                  context.bloc<RegistrationCubit>().emit(NoAgreeState(null));
                                }
                              } else {
                                if (index == 0) {
                                  isSelected = [true, false];
                                  context.bloc<RegistrationCubit>().emit(YesState());
                                }
                                if (index == 1) {
                                  isSelected = [false, true];
                                  context.bloc<RegistrationCubit>().emit(NoState(null));
                                }
                              }
                            },
                            isSelected: isSelected
                        )
                    ),
                    if (state is YesState || state is YesAgreeState || (state is ErrorState && state.yes)) Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(
                          "2. Впишите ЕГРИП / ЕГРЮЛ / ИНН (для индивидуальных предпринимателей / для учредителей юридических лиц / для самозанятых",
                          style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                          ),
                          textAlign: TextAlign.left,
                        ),
                    ),
                    if (state is YesState || state is YesAgreeState || (state is ErrorState && state.yes)) Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: TextField(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AnimatedContainer(
                                padding: MediaQuery.of(context).viewInsets,
                                duration: const Duration(milliseconds: 300),
                                child: new Card(
                                  margin: EdgeInsets.all(10.0),
                                  child: new Container(
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        TextField(
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                              prefixIcon: Icon(Icons.search, color: Colors.black)
                                          ),
                                          autofocus: true,
                                          controller: inn,
                                          style: TextStyle(
                                            fontFamily: 'Segoe UI',
                                            fontSize: 14,
                                          ),
                                          onChanged: (text) {
                                            context.bloc<CompanyInnCubit>().initial(text);
                                          },
                                        ),
                                        BlocBuilder<CompanyInnCubit, CompanyInnState>(
                                          builder: (context, stateInn) {
                                            if (stateInn is LoadedCompanyInnState) {
                                              return Expanded(
                                                child: Scrollbar(
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: stateInn.companyList.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return ListTile(
                                                        onTap: () {
                                                          inn.text = stateInn.companyList[index].inn;
                                                          Navigator.pop(context);
                                                        },
                                                        title: Text(
                                                          stateInn.companyList[index].name,
                                                          style: TextStyle(
                                                            fontFamily: 'Segoe UI',
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                          "ИНН: " + stateInn.companyList[index].inn + ", КПП: " + stateInn.companyList[index].inn,
                                                          style: TextStyle(
                                                            fontFamily: 'Segoe UI',
                                                            color: Colors.black54,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            }

                                            return Container();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          );
                        },
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                        ),
                        controller: inn,
                        decoration: InputDecoration(
                          hintText: "Название организации",
                          hintStyle: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0))
                          ),
                        ),
                      )
                    ),
                    if (state is ErrorState && !state.innNull && state.yes) Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Поле не заполнено",
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state is NoState || state is NoAgreeState || (state is ErrorState && !state.yes)) Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        "2. К какой категории вы себя относите?",
                        style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state is NoState) Padding(
                      padding: EdgeInsets.only(top:15),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 2,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoState(type));
                                    },
                                  ),
                                  Text(
                                    'Школьники (от 14 до 17)',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoState(2)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 3,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoState(type));
                                    },
                                  ),
                                  Text(
                                    'Лица до 30, в том числе студенты',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoState(3)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value:4,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoState(type));
                                    },
                                  ),
                                  Text(
                                    'Женщины в декретном отпуске',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoState(4)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 5,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoState(type));
                                    },
                                  ),
                                  Text(
                                    'Военнослужащие, уволенные в запас',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoState(5)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 6,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoState(type));
                                    },
                                  ),
                                  Text(
                                    'Лица старше 45 лет',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoState(6)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 7,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoState(type));
                                    },
                                  ),
                                  Text(
                                    'Безработные',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoState(7)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 8,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoState(type));
                                    },
                                  ),
                                  Text(
                                    'Инвалиды',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoState(8)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 9,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoState(type));
                                    },
                                  ),
                                  Text(
                                    'Выпускники и воспитанники детских домов',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoState(9)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 10,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoState(type));
                                    },
                                  ),
                                  Text(
                                    'Другое',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoState(10)),
                          ),
                        ],
                      ),
                    ),
                    if (state is NoAgreeState) Padding(
                      padding: EdgeInsets.only(top:15),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 2,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Школьники (от 14 до 17)',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(2)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 3,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Лица до 30, в том числе студенты',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(3)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 4,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Женщины в декретном отпуске',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(4)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 5,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Военнослужащие, уволенные в запас',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(5)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 6,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Лица старше 45 лет',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(6)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 7,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Безработные',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(7)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 8,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Инвалиды',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(8)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 9,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Выпускники и воспитанники детских домов',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(9)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 10,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Другое',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(10)),
                          ),
                        ],
                      ),
                    ),
                    if (state is ErrorState && !state.yes) Padding(
                      padding: EdgeInsets.only(top:15),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 2,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Школьники (от 14 до 17)',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(2)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 3,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Лица до 30, в том числе студенты',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(3)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 4,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Женщины в декретном отпуске',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(4)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 5,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Военнослужащие, уволенные в запас',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(5)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 6,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Лица старше 45 лет',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(6)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 7,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Безработные',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(7)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 8,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Инвалиды',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(8)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 9,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Выпускники и воспитанники детских домов',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(9)),
                          ),
                          GestureDetector(
                            child: Row(
                                children: [
                                  Radio(
                                    value: 10,
                                    groupValue: state.typePerson,
                                    onChanged:(type) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(type));
                                    },
                                  ),
                                  Text(
                                    'Другое',
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ]
                            ),
                            onTap: () => context.bloc<RegistrationCubit>().emit(NoAgreeState(10)),
                          ),
                        ],
                      ),
                    ),
                    if (state is ErrorState && !state.typeNull && !state.yes) Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Поле не заполнено",
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state is YesState || state is NoState || state is YesAgreeState || state is NoAgreeState || state is ErrorState) Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "3. Фамилия",
                                    style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Padding(padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0), child: Container()),
                                  TextField(
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 14,
                                    ),
                                    controller: surname,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(8.0),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(5.0))
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0), child: Container()),
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Имя",
                                  style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0), child: Container()),
                                TextField(
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 14,
                                  ),
                                  controller: name,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0), child: Container()),
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Отчество",
                                  style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0), child: Container()),
                                TextField(
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 14,
                                  ),
                                  controller: lastname,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                    if (state is ErrorState && !state.fioNull) Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Поле не заполнено",
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state is YesState || state is NoState || state is YesAgreeState || state is NoAgreeState || state is ErrorState) Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        "4. Дата Рождения",
                        style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state is YesState || state is NoState || state is YesAgreeState || state is NoAgreeState || state is ErrorState) Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: GestureDetector(
                        onTap: () async{
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1900, 3, 5),
                              maxTime: DateTime(2020, 12, 31),
                              theme: DatePickerTheme(
                                  itemStyle: TextStyle(
                                      color: Colors.black, fontFamily: 'Segoe UI', fontSize: 18),
                                  doneStyle: TextStyle(color: Colors.black, fontFamily: 'Segoe UI', fontSize: 16)),
                              onConfirm: (date) {
                                datebirthday.text = DateFormat("dd-MM-yyyy").format(DateTime.parse(date.toString()));
                                FocusScope.of(context).requestFocus(textFieldPhone);
                              }, currentTime: DateTime.now(), locale: LocaleType.ru);
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            keyboardType: null,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                            ),
                            controller: datebirthday,
                            inputFormatters: [MaskTextInputFormatter(mask: '##-##-####', filter: { "#": RegExp(r'[0-9]') })],
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(8.0),
                              hintText: "дд-мм-гггг",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (state is ErrorState && !state.dateNull) Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Поле не заполнено",
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state is YesState || state is NoState || state is YesAgreeState || state is NoAgreeState || state is ErrorState) Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        "5. Контактный телефон",
                        style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state is YesState || state is NoState || state is YesAgreeState || state is NoAgreeState || state is ErrorState) Container(
                      height: 50,
                      padding: EdgeInsets.only(top: 15.0),
                      child: TextField(
                        focusNode: textFieldPhone,
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 16,
                        ),
                        inputFormatters: [ MaskTextInputFormatter(mask: '+7 (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') }) ],
                        keyboardType: TextInputType.phone,
                        controller: phone,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset("assets/images/phone_icon.png", scale: 3),
                          hintText: "+7 (_ _ _) _ _ _ - _ _ - _ _",
                          hintStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0))
                          ),
                        ),
                      )
                    ),
                    if (state is ErrorState && !state.phoneNull) Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Поле не заполнено",
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state is ErrorState && state.phoneNull && !state.phoneUncorrect) Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Неккоректно указан телефон",
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state is YesState || state is NoState || state is YesAgreeState || state is NoAgreeState || state is ErrorState) Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        "6. Электронная почта",
                        style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state is YesState || state is NoState || state is YesAgreeState || state is NoAgreeState || state is ErrorState) Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                        ),
                        controller: email,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(8.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0))
                          ),
                        ),
                      )
                    ),
                    if (state is ErrorState && !state.emailNull) Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Поле не заполнено",
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state is ErrorState && state.emailNull && !state.emailUncorrect) Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Неккоректно указан email",
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state is YesState || state is NoState || state is YesAgreeState || state is NoAgreeState || state is ErrorState) Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        "7. Город",
                        style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    if (state is YesState || state is NoState || state is YesAgreeState || state is NoAgreeState || state is ErrorState) Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: TextField(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AnimatedContainer(
                                  padding: MediaQuery.of(context).viewInsets,
                                  duration: const Duration(milliseconds: 300),
                                  child: new Card(
                                    margin: EdgeInsets.all(10.0),
                                    child: new Container(
                                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                      child: new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          TextField(
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                                prefixIcon: Icon(Icons.search, color: Colors.black)
                                            ),
                                            autofocus: true,
                                            controller: city,
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 14,
                                            ),
                                            onChanged: (text) {
                                              context.bloc<CityListCubit>().initial(text);
                                            },
                                          ),
                                          BlocBuilder<CityListCubit, CityListState>(
                                            builder: (context, stateCity) {
                                              if (stateCity is LoadedCityListState) {
                                                return Expanded(
                                                  child: Scrollbar(
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: stateCity.cityList.length,
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return ListTile(
                                                          onTap: () {
                                                            city.text = stateCity.cityList[index].city;
                                                            region.text = stateCity.cityList[index].region;
                                                            code.text = stateCity.cityList[index].code;
                                                            Navigator.pop(context);
                                                          },
                                                          title: Text(
                                                            stateCity.cityList[index].city,
                                                            style: TextStyle(
                                                              fontFamily: 'Segoe UI',
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          subtitle: Text(
                                                            stateCity.cityList[index].name,
                                                            style: TextStyle(
                                                              fontFamily: 'Segoe UI',
                                                              color: Colors.black54,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }

                                              return Container();
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            );
                          },
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                          ),
                          controller: city,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0))
                            ),
                          ),
                        )
                    ),
                    if (state is YesState || state is NoState || state is YesAgreeState || state is NoAgreeState || state is ErrorState) Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: Checkbox(
                                  value: state is YesAgreeState || state is NoAgreeState || (state is ErrorState && state.agree),
                                  onChanged: (bool val) {
                                    if (state is YesState && val) {
                                      context.bloc<RegistrationCubit>().emit(YesAgreeState());
                                    }
                                    if (state is NoState && val) {
                                      context.bloc<RegistrationCubit>().emit(NoAgreeState(state.typePerson));
                                    }
                                    if (state is YesAgreeState && !val) {
                                      context.bloc<RegistrationCubit>().emit(YesState());
                                    }
                                    if (state is NoAgreeState && !val) {
                                      context.bloc<RegistrationCubit>().emit(NoState(state.typePerson));
                                    }
                                    if (state is ErrorState) {
                                      context.bloc<RegistrationCubit>().emit(ErrorState(
                                          state.typePerson,
                                          state.yes,
                                          val,
                                          state.typeNull,
                                          inn.text.length > 0,
                                          name.text.length > 0 && lastname.text.length > 0 && surname.text.length > 0,
                                          datebirthday.text.length > 0,
                                          phone.text.length > 0,
                                          email.text.length > 0,
                                          phone.text.length == 18,
                                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.text)
                                      ));
                                    }
                                  },
                                )
                            ),
                            if (state is NoState || state is NoAgreeState || (state is ErrorState && !state.yes)) Flexible(
                                flex: 5,
                                child: RichText(
                                  text: new TextSpan(
                                    children: [
                                      new TextSpan(
                                        text: 'Нажимая кнопку «Отправить ответы» вы даете согласие на обработку ',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 14,
                                          color: Colors.black
                                        ),
                                      ),
                                      new TextSpan(
                                        text: 'персональных данных',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 14,
                                          color: Colors.blueAccent
                                        ),
                                        recognizer: new TapGestureRecognizer()
                                          ..onTap = () {
                                          launch('https://isbusiness.ru/agreeperconaldata.pdf');
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                            ),
                            if (state is YesState || state is YesAgreeState || (state is ErrorState && state.yes)) Flexible(
                              flex: 5,
                              child: RichText(
                                text: new TextSpan(
                                  children: [
                                    new TextSpan(
                                      text: 'Нажимая кнопку «Отправить ответы» вы даете согласие на обработку ',
                                      style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 14,
                                          color: Colors.black
                                      ),
                                    ),
                                    new TextSpan(
                                      text: 'персональных данных',
                                      style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 14,
                                          color: Colors.blueAccent
                                      ),
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          launch('https://isbusiness.ru/agreeperconaldatabiz.pdf');
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                    if (state is YesAgreeState || state is NoAgreeState || (state is ErrorState && state.agree)) Container(
                        height: 38,
                        margin: EdgeInsets.only(top: 15.0),
                        child: FlatButton(
                          textColor: Colors.white,
                          color: Colors.blueAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Отправить ответы',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            var type = 1;
                            bool checkType = false;
                            if (state is NoAgreeState && state.typePerson != null) {
                              type = state.typePerson;
                              checkType = true;
                            }

                            if (state is ErrorState && state.typePerson != null && !state.yes) {
                              type = state.typePerson;
                              checkType = true;
                            }

                            if ((inn.text.length > 0 || checkType) && name.text.length > 0 && lastname.text.length > 0 && surname.text.length > 0
                            && datebirthday.text.length > 0 && phone.text.length > 0 && email.text.length > 0
                                && phone.text.length == 18 && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.text)) {
                              if (region.text == null) region.text = "";
                              var body = {
                                "id_region": region.text,
                                "type_person": type.toString(),
                                "inn": inn.text,
                                "city": city.text,
                                "postal_code": code.text,
                                "name": name.text,
                                "surname": surname.text,
                                "last_name": lastname.text,
                                "birthday": datebirthday.text.split("-")[2] + "-" + datebirthday.text.split("-")[1] + "-" + datebirthday.text.split("-")[0],
                                "email": email.text,
                                "phone_number": phone.text.replaceAll(RegExp(r"[^0-9]+"), ""),
                                "flag_app":true
                              };

                              print(body);
                              await context.bloc<RegistrationCubit>().send(body, context, phone.text.replaceAll(RegExp(r"[^0-9]+"), ""));
                            } else {
                              if (state is ErrorState) {
                                context.bloc<RegistrationCubit>().emit(ErrorState(
                                    type,
                                    state.yes,
                                    true,
                                    checkType,
                                    inn.text.length > 0,
                                    name.text.length > 0 && lastname.text.length > 0 && surname.text.length > 0,
                                    datebirthday.text.length > 0,
                                    phone.text.length > 0,
                                    email.text.length > 0,
                                    phone.text.length == 18,
                                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.text)
                                ));
                              } else context.bloc<RegistrationCubit>().emit(ErrorState(
                                  type,
                                  state is YesAgreeState,
                                  true,
                                  checkType,
                                  inn.text.length > 0,
                                  name.text.length > 0 && lastname.text.length > 0 && surname.text.length > 0,
                                  datebirthday.text.length > 0,
                                  phone.text.length > 0,
                                  email.text.length > 0,
                                  phone.text.length == 18,
                                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.text)
                              ));
                            }
                          },
                        )),
                    if (state is YesState || state is NoState || (state is ErrorState && !state.agree)) Container(
                        height: 38,
                        margin: EdgeInsets.only(top: 15.0),
                        child: FlatButton(
                          textColor: Colors.black54,
                          color: Colors.black12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Отправить ответы',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                          },
                        )),
                  ],
                ),
              )
            ],
          );
        },
      )
    );
  }
}