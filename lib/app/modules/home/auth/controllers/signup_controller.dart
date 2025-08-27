import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:azmatka/constants/values.dart';

class SignupController extends GetxController {
  TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
    TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var key = GlobalKey<FormState>();
  var box = GetStorage();
  final showPass = false.obs;

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

  changePass() async {
    showPass.value=!showPass.value;
  }

  signupApi() async {
    String name = nameController.text;
    String email = '';
    String mobile = mobileController.text;
    String password = passwordController.text;
    Map<String, dynamic> body = {
      'registerData': jsonEncode({'name': name, 'email': email, 'mobile': mobile, 'password': password}),
    };

    if (key.currentState!.validate()) {
      try {
        var res = await ApiProvider().postRequest2(apiUrl: 'user/register', data: body);
        var data = jsonDecode(res);
        toast(data['message']);
        await box.erase();
        await box.write('token', data['data']['token']);
        await box.write('name',name);
        await box.write('email',email);
        await box.write('is_registered',1);
        await box.write('mobile_number',mobile);
        Get.offAllNamed('/home');
      } catch (e) {
        print(e.toString());
        var data= jsonDecode(e.toString());
        toast(data['message']);
        if(data['is_registered']){
          Get.offAllNamed('/login');
        }
      }
    }
  }
}
