import 'package:azmatka/constants/values.dart';

class NewPasswordController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
  changePasswordApi() async {
    if (oldPasswordController.text.isEmpty) {
      toast('Please enter current password');
    } else if (newPasswordController.text.isEmpty) {
      toast('Please enter new password');
    } else if (confirmPasswordController.text.isEmpty) {
      toast('Please enter confirm password');
    } else if (newPasswordController.text != confirmPasswordController.text) {
      toast('New password and confirm password does not match');
    } else {
      var d = {
        'userId': userId(),
        'oldPassword': oldPasswordController.text,
        'password': newPasswordController.text,
      };
      try {
        var res = await ApiProvider()
            .postRequest(apiUrl: 'change_password.php', data: d);
        if (res['success'].toString() == '1') {
          Get.back();
        }
        toast(res['message']);
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
