import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:azmatka/constants/values.dart';


class LoginController extends GetxController {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var box = GetStorage();
  final showPass=false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  loginApi() async {
    String mobile = mobileController.text;
    String password = passwordController.text;
    if (mobile.length != 10) {
      toast('Please Enter a valid number');
    } else {
      Map<String, dynamic> body = {
        'mobile_number': mobileController.text,
        'password': password,
      };
      try {
        var res = await ApiProvider().postRequest2(apiUrl: 'user/login', data: body);
        var data = jsonDecode(res);
        await box.erase();
        await  box.write('token', data['data']['token']);
        await  box.write('name', data['data']['user']['name']);
        await  box.write('phone', data['data']['user']['phone']);
        box.write('mobile_number', mobileController.text);
        await box.write('is_registered',1);

        Get.offNamed('/home');
      } catch (e) {
        if(jsonDecode(e.toString()).containsKey('message')){
          
          Fluttertoast.showToast(msg: jsonDecode(e.toString())['message']);
        }
        print(e.toString());
        if(jsonDecode(e.toString()).containsKey('is_registered')){
          box.erase();
          Get.offAllNamed('/signup');
        }
      }
    }
  }
}
