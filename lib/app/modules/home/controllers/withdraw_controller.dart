import 'package:azmatka/app/modules/home/views/home_view.dart';
import 'package:azmatka/constants/values.dart';

class WithdrawController extends GetxController {
  TextEditingController pointContoller = TextEditingController();
  final selectvalue = 1.obs;
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
  withdrawApi() async {

    if (pointContoller.text.isEmpty) {
      toast('Please Enter Points');
    } else {
      var d = {
        // 'app_id': appId(),
        // 'user_id': userId(),
        'amount': pointContoller.text,
        // 'device_id': deviceId(),
        'source': selectvalue.value == 1
            ? 'bank'
            : selectvalue.value == 2
                ? 'paytm'
                : selectvalue.value == 3
                    ? 'phonepay'
                    : 'googlepay'
      };
      try {
        var res = await ApiProvider().postRequest(
            apiUrl: 'user/debit_money_from_wallet',
            data: d,
            temp: true,
            token: '${box.read('token')}');
        if (res['success'].toString() == 'true') {
          toast(res['message'].toString());
          Get.to(() => HomeView());
        } else {
          toast(res['message'].toString());
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
