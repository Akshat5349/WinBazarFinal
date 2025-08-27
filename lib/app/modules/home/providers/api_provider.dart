import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:azmatka/widgets/base_url.dart';

class ApiProvider {
  Future<dynamic> getRequest(
      {required apiUrl, data = const <String, String>{}, token}) async {
    var res = await http.get(Uri.parse('$BASE_URL$apiUrl'),
        headers: {'Authorization': '${token}',"Access-Control-Allow-Origin": "*",});
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

  Future<dynamic> getRequest2(
      {required apiUrl, data = const <String, String>{}, token}) async {
    print(token);
    print(apiUrl);
    var res = await http.get(Uri.parse('$BASE_URL$apiUrl'),
        headers: {'Authorization': '${token}',"Access-Control-Allow-Origin": "*"});
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

  Future<dynamic> getRequest3(
      {required apiUrl, data = const <String, String>{}, token}) async {
    print(token);
    print(apiUrl);
    var res = await http.get(Uri.parse('$BASE_URL$apiUrl'),
        headers: {'Authorization': '${token}',"Access-Control-Allow-Origin": "*"});
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
      {required apiUrl, data = const <String, String>{}, token, temp}) async {
    // print(data);
    var res = await http.post(Uri.parse('$BASE_URL$apiUrl'),
        body: temp ? data : {'token': token},
        headers: {'Accept': 'application/json', 'Authorization': '${token}',"Access-Control-Allow-Origin": "*"});
    //print(res.statusCode);
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

  Future<dynamic> postRequest2(
      {required apiUrl, data = const <String, String>{}, token}) async {
    var res = await http.post(Uri.parse('$BASE_URL$apiUrl'),
        body: data,
        headers: {'Accept': 'application/json', 'Authorization': '${token}',"Access-Control-Allow-Origin": "*"});

    if (res.statusCode == 200 || res.statusCode == 201) {
      return res.body;
    } else if (res.statusCode == 401) {
      return Future.error(res.body);
    } else if (res.statusCode == 404) {
      return Future.error(res.body);
    } else {
      return Future.error(res.body);
    }
  }
}
