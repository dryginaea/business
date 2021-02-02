import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/login/logincubit.dart';
import 'package:isbusiness/cubit/login/loginstate.dart';
import 'package:isbusiness/router/router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController codeController = TextEditingController();
    String phone;
    var maskPhone = new MaskTextInputFormatter(mask: '+7 (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });
    var maskCode = new MaskTextInputFormatter(mask: '# # # #', filter: { "#": RegExp(r'[0-9]') });

    context.bloc<LoginCubit>().emit(InitialState());
    return Scaffold(
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoadingState) return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent)));
            if (state is CheckPhoneInDBTrueState) {
              context.bloc<LoginCubit>().sendSMSCode(state.phone);
              return Container(
                margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(flex: 1, child: Image.asset('assets/images/logo.png')),
                              Expanded(flex: 1, child: Container()),
                            ],
                          ),
                        ),
                    ),
                    Flexible(
                        flex: 3,
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.asset('assets/images/auth_preview.png'),
                        ),
                    ),
                    Flexible(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Вход',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Код подтверждения',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              height: 40,
                              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                              child: TextField(
                                autofocus: true,
                                cursorColor: Colors.indigo,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Segoe UI',
                                  fontSize: 16,
                                ),
                                inputFormatters: [maskCode],
                                controller: codeController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  prefixIcon: Image.asset("assets/images/key.png", scale: 3),
                                  hintText: "_ _ _ _",
                                  hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'Segoe UI',
                                    fontSize: 16,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black12, width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black12, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(0.0))
                                  ),
                                ),
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
                                        'Подтвердить',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    context.bloc<LoginCubit>().auth(phone, codeController.text.replaceAll(" ", ""), context);
                                  },
                                )),
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Не пришел код? ',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      'Выслать код еще раз',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14,
                                        color: const Color(0xff295adf),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                )
                            ),
                          ],
                        )
                    )
                  ],
                ),
              );
            }

            return Container(
              margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: Image.asset('assets/images/logo.png')),
                          Expanded(flex: 1, child: Container()),
                        ],
                      ),
                    )
                  ),
                  Flexible(
                    flex: 3,
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset('assets/images/auth_preview.png'),
                    ),
                  ),
                  Flexible(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                            child: Text(
                              'Вход',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 32,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          if (state is CheckPhoneInDBErrorState) Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                            child: Text(
                              'Ошибка соединения',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: Colors.red
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Номер телефона',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            height: 40,
                            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                            child: TextField(
                              cursorColor: Colors.indigo,
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Segoe UI',
                                fontSize: 16,
                              ),
                              inputFormatters: [maskPhone],
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                prefixIcon: Image.asset("assets/images/phone_icon.png", scale: 3),
                                hintText: "+7 (_ _ _) _ _ _ - _ _ - _ _",
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Segoe UI',
                                  fontSize: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(0.0))
                                ),
                              ),
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
                                      'Далее',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  phone = phoneController.text.replaceAll(RegExp(r"[^0-9]+"), "");
                                  print(phone);
                                  context.bloc<LoginCubit>().checkPhone(phone, context);
                                },
                              )),
                          Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Еще нет аккаунта? ',
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      'Регистрация здесь',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 14,
                                        color: const Color(0xff295adf),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context, registrationRoute);
                                    },
                                  )
                                ],
                              )
                          ),
                        ],
                      )
                  )
                ],
              ),
            );
          },
        )
    );
  }
}