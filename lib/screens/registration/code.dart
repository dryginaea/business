import 'package:flutter/material.dart';
import 'package:isbusiness/cubit/registration/registrationcubit.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CodeRegistration extends StatelessWidget {
  String phone;
  String token;

  CodeRegistration(this.phone, this.token);

  @override
  Widget build(BuildContext context) {
    var code = TextEditingController();
    var maskCode = new MaskTextInputFormatter(mask: '# # # #', filter: { "#": RegExp(r'[0-9]') });
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Image.asset('assets/images/logo.png')),
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 3,
              child: Image.asset('assets/images/auth_preview.png'),
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Код подтверждения',
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
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
                        controller: code,
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
                            context.bloc<RegistrationCubit>().checkSMSCode(phone, context, code.text.replaceAll(" ", ""), token);
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
                            TextButton(
                              onPressed: () async{
                                context.bloc<RegistrationCubit>().refreshCode(phone, context);
                              },
                              child: Text(
                              'Выслать код еще раз',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: const Color(0xff295adf),
                              ),
                              textAlign: TextAlign.left,
                            ),)
                          ],
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: Row(
                          children: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Вернуться назад',
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                            ),
                          ],
                        )
                    ),
                  ],
                )
            )
          ],
        ),
      )
    );
  }
}