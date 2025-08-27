import 'package:dio/dio.dart';

class DioProvider {
  static const BASE_URL = 'http://teacher.24medzon.com/shopdemo/public/api/';
  var dio = Dio();
  Future<dynamic> postRequest(
      {required apiUrl, data = const <String, String>{}}) async {
    var resP = await dio.post(
      'http://teacher.24medzon.com/shopdemo/public/api/$apiUrl',
      data: data,
    );

    // if (res.statusCode == 200) {
    //   return res.body;
    // } else if (res.unauthorized) {
    //   return Future.error(res.body);
    // } else if (res.statusCode == 404) {
    //   return Future.error(res.body);
    // } else if (res.statusCode == 500) {
    //   return Future.error(res.body);
    // } else {
    //   return Future.error('Network Problem');
    // }
  }
}
