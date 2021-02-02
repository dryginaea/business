import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:http_parser/http_parser.dart';
import 'package:isbusiness/data/auth/auth.dart';
import 'package:isbusiness/data/checkphoneindb/checkphoneindb.dart';
import 'package:isbusiness/data/course/course.dart';
import 'package:isbusiness/data/courseInfo/courseInfo.dart';
import 'package:isbusiness/data/eventinfo/eventinfo.dart';
import 'package:isbusiness/data/interests/interests.dart';
import 'package:isbusiness/data/lessoninfo/lessoninfo.dart';
import 'package:isbusiness/data/lessons/lessons.dart';
import 'package:isbusiness/data/partnerproject/partnerproject.dart';
import 'package:isbusiness/data/privilege/privilege.dart';
import 'package:isbusiness/data/product/product.dart';
import 'package:isbusiness/data/project/projects.dart';
import 'package:isbusiness/data/projectInfo/projectInfo.dart';
import 'package:isbusiness/data/questions/questions.dart';
import 'package:isbusiness/data/rates/rates.dart';
import 'package:isbusiness/data/user/userdata.dart';
import 'package:isbusiness/oauth/SecureStorage.dart';

class ApiService {
  OAuthSecureStorage storage;
  Dio dio;
  DioCacheManager dioCacheManager;

  ApiService() {
    storage = OAuthSecureStorage();
    dio = Dio();
    dioCacheManager = DioCacheManager(CacheConfig());
    dio.interceptors.add(dioCacheManager.interceptor);
    //dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<void> saveToken(String token) async {
    await storage.saveToken(token);
  }

  Future<String> getToken() async {
    return await storage.fetch();
  }

  Future<void> deleteToken() async {
    await storage.deleteToken();
  }

  Future<void> saveAvatar() async {
    await storage.saveAvatar("#${DateTime.now().toString().replaceAll(" ", "")}");
  }

  Future<String> getAvatar() async {
    return await storage.getAvatar();
  }

  Future<void> savePromocode(String promo) async {
    await storage.savePromocode(promo);
  }

  Future<String> getPromocode() async {
    return await storage.getPromocode();
  }

  Future<void> deletePromocode() async {
    return await storage.deletePromocode();
  }

  Future<void> updateFCMToken (String tokenPush, String device) async{
    final token = await getToken();
    print(jsonEncode(<String, String>{
      'token': tokenPush,
      'id_device': device
    }));

    Response response = await dio.post(
        'https://inficomp.ru/anketa/api/user/updatefirebasetoken.php',
        data: jsonEncode(<String, String>{
          'token': tokenPush,
          'id_device': device
        }),
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    print(response.data);
  }

  Future<bool> getStatusPush() async{
    final token = await getToken();
    dio.options.headers['Authorization'] = 'Bearer $token';
    Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
    Response response = await dio.post(
        'https://inficomp.ru/anketa/api/user/getstatuspush.php',
        options: _cacheOptions);

    print(response.data);
    return jsonDecode(response.data)["status_push"];
  }

  Future<void> setStatusPush(bool value) async{
    final token = await getToken();
    Response response = await dio.post(
        'https://inficomp.ru/anketa/api/user/allowpush.php',
        data: {
          "allow": value
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    print(response.data);
  }

  Future<CheckPhoneInDB> checkPhoneInDB(String phone) async {
    try {
      Response response = await dio.post(
        'https://inficomp.ru/anketa/api/user/checkphoneindb.php',
        data: {
          'phone_number': phone,
        },
      );

      print(response.data);
      return CheckPhoneInDB.fromJson(jsonDecode(response.data));
    } catch (e) {
      print("hi");
      throw Exception(e);
    }
  }


  Future<CheckPhoneInDB> sendSMS(String phone) async {
    print('https://inficomp.ru/anketa/api/confirmationbysms/sendsms.php');
    try {
      Response response = await dio.post(
        'https://inficomp.ru/anketa/api/confirmationbysms/sendsms.php',
        data: jsonEncode(<String, String>{
          'phone_number': phone,
        }),
      );

      print(response.data);
      return CheckPhoneInDB.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Auth> authUser(String phone, String code) async {
    print('https://inficomp.ru/anketa/api/user/auth.php');
    try {
      Response response = await dio.post(
        'https://inficomp.ru/anketa/api/user/auth.php',
        data: jsonEncode(<String, String>{
          'phone_number': phone,
          'code': code
        }),
      );

      print(response.data);
      return Auth.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Auth> sendInterview(Map<String, dynamic> interview) async {
    try {
      Response response = await dio.post(
        'https://inficomp.ru/anketa/api/interview/send.php',
        data: jsonEncode(interview),
      );

      print(response.data);
      return Auth.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CheckPhoneInDB> checkSMS(String phone, String code, String token) async {
    try {
      Response response = await dio.post(
        'https://inficomp.ru/anketa/api/confirmationbysms/checkcodesms.php',
        data: jsonEncode(<String, String>{
          'phone_number': phone,
          'code': code
        }),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        )
      );

      print(response.data);
      return CheckPhoneInDB.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Courses> getCourses(List<int> list, int free) async {
    print(list);
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/course/getlist.php',
          data: jsonEncode(<String, dynamic>{
            "interests": list,
            "free_tariff": free
          }),
          options: _cacheOptions
      );

      return Courses.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Courses> getCoursesPromocode(String promo) async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/course/getlistbypromocode.php',
          data: jsonEncode(<String, dynamic>{
            "promocode": promo
          }),
          options: _cacheOptions
      );

      print(jsonDecode(response.data));
      return Courses.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CourseInfo> getCourse(String id) async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/course/read.php',
          data: jsonEncode(<String, dynamic>{
            "id_course": id
          }),
          options: _cacheOptions
      );

      print(response.data);
      return CourseInfo.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Courses> getMyCourses() async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/user/getmycourses.php',
          data: jsonEncode(<String, dynamic>{
            "limit":999,
            "offset":0
          }
          ),
          options: _cacheOptions
      );

      return Courses.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> checkCourse(String id) async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/course/checkaccesstocourse.php',
          data: jsonEncode(<String, dynamic>{
            "id_course": id
          }),
          options: _cacheOptions
      );

      return jsonDecode(response.data)["status"];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Lessons> getCourseLessons(String id) async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/lesson/getlistlessons.php',
          data: jsonEncode(<String, dynamic>{
            "id_course": id
          }),
          options: _cacheOptions
      );

      print(response.data);
      return Lessons.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Questions> getCourseQuestions(String id) async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/course/getcoursequestions.php',
          data: jsonEncode(<String, dynamic>{
            "id_course": id
          }),
          options: _cacheOptions
      );

      print(response.data);
      return Questions.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> sendCourseQuestions(String id, String question) async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/user/createcoursequestion.php',
          data: jsonEncode(<String, dynamic>{
            "id_course": id,
            "question": question
          }),
          options: _cacheOptions
      );

      print(response.data);
      return jsonDecode(response.data)["status"] == "success";
    } catch (e) {
      throw Exception(e);
    }
  }



  Future<Rates> getCourseRates(String id) async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/course/getlistcourserates.php',
          data: jsonEncode(<String, dynamic>{
            "id_course": id
          }),
          options: _cacheOptions
      );

      print(response.data);
      return Rates.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<LessonInfo> getLessonInfo(String id) async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/lesson/read.php',
          data: jsonEncode(<String, dynamic>{
            "id_lesson": id
          }),
          options: _cacheOptions
      );

      print(response.data);
      return LessonInfo.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> buyCourse(String id_course, String id) async {
    try {
      final token = await getToken();
      final promo = await getPromocode();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/course/createapplication.php',
          data: jsonEncode(<String, dynamic>{
            "id_course": id_course,
            "id_tariff": id,
            "promocode": promo.toString()
          }),
          options: _cacheOptions
      );

      print(response.data);
      if (jsonDecode(response.data)['status'] == "success") await deletePromocode();
      return jsonDecode(response.data)['status'] == "success";
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Projects> getProjects() async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/project/getprojectsfordashboard.php',
          data: jsonEncode(<String, String>{
            'limit': "999",
            'offset': "0"
          }),
          options: _cacheOptions
      );

      print(response.data);
      return Projects.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ProjectInfo> getProject(String id) async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/project/getinfo.php',
          data: jsonEncode(<String, String>{
            "id_project": id
          }
          ),
          options: _cacheOptions
      );

      print(response.data);
      return ProjectInfo.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> checkProject(String id) async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/project/checkregistration.php',
          data: jsonEncode(<String, String>{
            "id_project": id
          }
          ),
          options:_cacheOptions
      );

      print(response.data);
      return jsonDecode(response.data)["status"];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> registrationProject(String id) async {
    try {
      final token = await getToken();
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/project/registrationforproject.php',
          data: jsonEncode(<String, String>{
            "id_project": id
          }
          ),
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          )
      );

      print(response.data);
      return jsonDecode(response.data)["message"];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> cancelProject(String id) async {
    try {
      final token = await getToken();
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/project/cancelregistration.php',
          data: jsonEncode(<String, String>{
            "id_project": id
          }
          ),
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          )
      );

      print(response.data);
      return jsonDecode(response.data)["status"];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<EventInfo> getEvent(String id) async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/event/getinfo.php',
          data: jsonEncode(<String, String>{
            "id_event": id
          }
          ),
          options: _cacheOptions
      );

      print(response.data);
      return EventInfo.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getBalls() async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/user/getballs.php',
          options: _cacheOptions
      );

      print(response.data);
      return jsonDecode(response.data)["balls"].toString();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Products> getProducts() async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/shop/getproducts.php',
          data: jsonEncode(<String, String>{
            'limit': "999",
            'offset': "0"
          }),
          options: _cacheOptions
      );

      print(response.data);
      return Products.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> buyItem(String id) async {
    try {
      final token = await getToken();
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/shop/buyitem.php',
          data: jsonEncode(<String, String>{
            "id_shop_item": id
          }),
          options: Options(headers: {'Authorization': 'Bearer $token'},)
      );

      print(response.data);
      return jsonDecode(response.data)["balance"].toString();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Events> getMyEvents() async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
        'https://inficomp.ru/anketa/api/user/getmyevents.php',
        data: jsonEncode(<String, String>{
          'limit': "999",
          'offset': "0"
        }),
        options: _cacheOptions
      );

      print(response.data);
      return Events.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Events> getPastEvents() async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
          'https://inficomp.ru/anketa/api/user/getmypastevents.php',
          data: jsonEncode(<String, String>{
            'limit': "999",
            'offset': "0"
          }),
          options: _cacheOptions
      );

      print(response.data);
      return Events.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<PartnerProjects> getPartnersEvents() async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
        'https://inficomp.ru/anketa/api/event/getpartnersevents.php',
        options: _cacheOptions
      );

      print(response.data);
      return PartnerProjects.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserData> getUserData() async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
        'https://inficomp.ru/anketa/api/user/getinfo.php',
        options: _cacheOptions
      );

      print(response.data);
      return UserData.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<PrivilegeList> getPrivilege() async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
        'https://inficomp.ru/anketa/api/privilege/getprivilege.php',
        options: _cacheOptions,
        data: jsonEncode(<String, String>{
          'limit': "999",
          'offset': "0"
        }),
      );

      print(response.data);
      return PrivilegeList.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> registrationForPrivilege(String id) async {
    try {
      final token = await getToken();
      Response response = await dio.post(
        'https://inficomp.ru/anketa/api/privilege/registrationforprivilege.php',
        options: Options(headers: {'Authorization': 'Bearer $token'},),
        data: jsonEncode(<String, String>{
          'id_privilege': id,
        }),
      );

      print(response.data);
      return jsonDecode(response.data)["status"];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> checkUserAvatar() async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await dio.post(
        'https://inficomp.ru/anketa/api/user/existuseravatar.php',
      );

      if (jsonDecode(response.data)["status"]) await saveAvatar();
      print(response.data);
      return jsonDecode(response.data)["status"];
    } catch (e) {
      var avatar = await getAvatar();
      if (avatar.length > 0) return true;
      else return false;
    }
  }

  Future<Interests> getInterests() async {
    try {
      final token = await getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Options _cacheOptions = buildCacheOptions(Duration(days: 360), forceRefresh: true);
      Response response = await dio.post(
        'https://inficomp.ru/anketa/api/user/getinterests.php',
        options: _cacheOptions
      );

      print(response.data);
      return Interests.fromJson(jsonDecode(response.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setInfo(Map<String, dynamic> info) async {
    try {
      final token = await getToken();
      Response response = await dio.post(
        'https://inficomp.ru/anketa/api/user/setinfo.php',
        data: jsonEncode(info),
        options: Options(headers: {'Authorization': 'Bearer $token'},)
      );

      print(response.data);
      if (!jsonDecode(response.data)['status']) throw Exception();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateAvatar(File image) async {
    String filename = image.path.split('/').last;
    final token = await getToken();
    FormData formData = FormData.fromMap({
      "image" :
      await MultipartFile.fromFile(image.path, filename: filename,
          contentType: MediaType('image', 'png'))
    });

    Response response = await dio.post('https://inficomp.ru/anketa/api/user/updateuseravatar.php', data: formData, options:  Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
    ));

    print(response.data);
  }
}