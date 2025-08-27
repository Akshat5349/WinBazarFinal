import 'dart:convert';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/base_url.dart';

class GetApiProvider extends GetConnect {
  Future<dynamic> getRequest(
      {required apiUrl, data = const <String, String>{}, token}) async {
    var res =
        await get('$BASE_URL$apiUrl', headers: {'Authorization': '${token}',"Access-Control-Allow-Origin": "*"});
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else if (res.statusCode == 401) {
      return Future.error(res.body);
    } else if (res.statusCode == 404) {
      return Future.error(res.body);
    } else if (res.statusCode == 500) {
      return Future.error(res.body);
    } else {
      return Future.error('Network Problem');
    }
  }

  Future<dynamic> postRequest(
      {required apiUrl, data = const <String, String>{}, token}) async {
    var res = await post('$BASE_URL$apiUrl', data,
        headers: {'Accept': 'application/json', 'Authorization': '${token}',"Access-Control-Allow-Origin": "*"});
    //print(res.body);
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else if (res.statusCode == 401) {
      return Future.error(res.body);
    } else if (res.statusCode == 404) {
      return Future.error(res.body);
    } else if (res.statusCode == 500) {
      return Future.error(res.body);
    } else {
      return Future.error('Network Problem');
    }
  }
}
