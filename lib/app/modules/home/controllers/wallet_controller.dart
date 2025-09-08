import 'package:azmatka/app/modules/home/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WalletController extends GetxController {
  final walletHistory = [].obs;
  final balance = ''.obs;
  final loading = false.obs;
  @override
  void onInit() {
    super.onInit();
    walletApi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  var box = GetStorage();
  walletApi() async {
    loading.value = true;
    try {
      var res = await ApiProvider().getRequest(
          apiUrl: 'user/get_user_wallet_details',
          token: "Bearer ${box.read('token')}");
      walletHistory.clear();
      walletHistory.addAll(res['data']['transactions']);
      print(walletHistory.length);
      balance.value = res['data']['wallet_balance'].toString();
    } catch (e) {
      print(e.toString());
    }
    loading.value = false;
  }
}
