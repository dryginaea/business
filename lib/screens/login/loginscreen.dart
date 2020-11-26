import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/cubit/login/logincubit.dart';
import 'package:isbusiness/cubit/login/loginstate.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    context.bloc<LoginCubit>().emit(InitialState());
    TextEditingController phoneController = TextEditingController();
    TextEditingController codeController = TextEditingController();
    String phone;
    var maskFormatter = new MaskTextInputFormatter(mask: '+7 (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });
    return Scaffold(
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is AuthTrueState) {
              return Center(child: Text(state.token));
            }

            if (state is LoadedState) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is CheckPhoneInDBTrueState) {
              context.bloc<LoginCubit>().sendSMSCode(state.phone);
              return Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Вход",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: codeController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Код"
                          ),
                        ),
                      ),
                      Container(
                          height: 50,
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: FlatButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            child:
                            Text("Далее"),
                            onPressed: () async {
                              print(phone);
                              context.bloc<LoginCubit>().auth(phone, codeController.text);
                            },
                          )),
                    ],
                  )
              );
            }

            return Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Вход",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    if (state is CheckPhoneInDBFalseState) Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Пользователя с таким номером не существует.",
                        )),
                    if (state is CheckPhoneInDBErrorState) Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Ошибка сети.",
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        inputFormatters: [maskFormatter],
                        controller: phoneController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Номер телефона"
                        ),
                      ),
                    ),
                    Container(
                        height: 50,
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: FlatButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          child:
                          Text("Далее"),
                          onPressed: () async {
                            phone = phoneController.text.replaceAll(RegExp(r"[^\w]"), "");
                            context.bloc<LoginCubit>().checkPhone(phone);
                          },
                        )),
                  ],
                )
            );
          },
        )
    );
  }
}