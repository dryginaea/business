import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:isbusiness/data/auth/auth.dart';
import 'package:isbusiness/data/checkphoneindb/checkphoneindb.dart';

Future<CheckPhoneInDB> sendSMS(String phone) async {
  try {
    final http.Response response = await http.post(
      'https://inficomp.ru/anketa/api/confirmationbysms/sendsms.php',
      body: jsonEncode(<String, String>{
        'phone_number': phone,
      }),
    );

    return CheckPhoneInDB.fromJson(jsonDecode(response.body));
  } catch (e) {
    throw Exception(e);
  }
}

Future<CheckPhoneInDB> checkPhoneInDB(String phone) async {
  try {
    final http.Response response = await http.post(
      'https://inficomp.ru/anketa/api/user/checkphoneindb.php',
      body: jsonEncode(<String, String>{
        'phone_number': phone,
      }),
    );

    return CheckPhoneInDB.fromJson(jsonDecode(response.body));
  } catch (e) {
    throw Exception(e);
  }
}

Future<Auth> authUser(String phone, String code) async {
  try {
    final http.Response response = await http.post(
      'https://inficomp.ru/anketa/api/user/auth.php',
      body: jsonEncode(<String, String>{
        'phone_number': phone,
        'code': code
      }),
    );

    return Auth.fromJson(jsonDecode(response.body));
  } catch (e) {
    throw Exception(e);
  }
}