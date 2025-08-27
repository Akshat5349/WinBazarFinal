import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:azmatka/constants/values.dart';


class ForgotPasswordController extends GetxController {
  TextEditingController mobileController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
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
  forgotApi() async {
    String mobile = mobileController.text;
    if (mobile.length != 10) {
      toast('Please Enter a valid number');
    } else {
      Map<String, dynamic> body = {
        'mobile_number': mobileController.text,
      };
      try {
        var res = await ApiProvider().postRequest2(apiUrl: 'user/forgot', data: body);
        var data = jsonDecode(res);
        toast(data['message']);
        await box.erase();
        await box.write('mobile_number', mobileController.text);
        Get.offNamed('/otpverify');
      } catch (e) {
        print(e.toString());
        var data = jsonDecode(e.toString());
        if(data.containsKey('message')){
          
          Fluttertoast.showToast(msg: data['message']);
        }
        if(data.containsKey('is_registered')){
          if(!(data['is_registered']))
          await box.erase();
          Get.offAllNamed('/signup');
        }
      }
    }
  }
}
