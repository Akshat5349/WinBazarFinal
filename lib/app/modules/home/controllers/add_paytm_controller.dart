import 'package:azmatka/constants/values.dart';
import 'package:get_storage/get_storage.dart';

class AddPaytmController extends GetxController {
  TextEditingController mobileController = TextEditingController();
  var title = Get.arguments['title'];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getBankApi();
  }

  @override
  void onClose() {}
  var box = GetStorage();

  addBankApi() async {
    if (mobileController.text.length != 10) {
      toast('Please Enter Valid Mobile Number');
    } else {
      var d = {
        title == 'Paytm'
            ? 'paytm_no'
            : title == 'PhonePe'
                ? 'phonePe_no'
                : 'googlePay_no': mobileController.text,
        'token': box.read('token'),
      };

      try {
        var res = await ApiProvider().postRequest2(
            apiUrl: 'user/profile-update',
            data: d,
            token: 'Bearer ${box.read('token')}');
        // toast(jsonDecode(res['message']).toString());
        Get.back();
      } catch (e) {
        toast(e.toString());
        print(e.toString());
      }
    }
  }

  getBankApi() async {
    try {
      var res = await ApiProvider().postRequest(temp:true,
          apiUrl: 'user/get_user_profile',
          token: '${box.read('token')}',
          data: {'token': box.read('token')});

      mobileController.text = title == 'Paytm'
          ? res['paytm_no'] ?? ""
          : title == 'PhonePe'
              ? res['phonePe_no'] ?? ""
              : res['googlePay_no'] ?? "";
    } catch (e) {
      print(e.toString());
    }
  }
}
