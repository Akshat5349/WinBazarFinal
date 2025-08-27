import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:azmatka/app/modules/home/views/home_view.dart';
import 'package:azmatka/constants/values.dart';

class OtpController extends GetxController {
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final showPass = false.obs;
  var box = GetStorage();
  var key = GlobalKey<FormState>();
  @override
  void onInit() async {
    super.onInit();
    if(box.read('mobile_number')==null){
      Get.offAllNamed('/forgot');
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  verifyOtp() async {
    String otp = otpController.text;
    String mobile_number = box.read('mobile_number');
    if (otp.length != 4) {
      toast('Please Enter a valid otp');
    } else {
      Map<String, dynamic> body = {
        'mobile_number': mobile_number,
        'otp': otpController.text,
        'password' : passwordController.text
      };
      if (key.currentState!.validate()) {  
      try {
        var res = await ApiProvider()
            .postRequest2(apiUrl: 'user/otp-verify', data: body);

        var data = jsonDecode(res);
        var token = data['data']['token'];
        await box.write('token', token);
        await box.write('is_registered',1);

          Get.offAll(HomeView());
      } catch (e) {
        print(e.toString());
      }
      }
    }
  }
}
