import 'package:azmatka/constants/values.dart';

class WalletHistoryController extends GetxController {
  final loading = false.obs;
  final wallet = [].obs;
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
  walletApi() async {
    try {
      var res =
          await ApiProvider().postRequest(apiUrl: 'wallet_history.php', data: {
        'dev_id': deviceId(),
        'app_id': appId(),
        'user_id': userId(),
      });
      wallet.addAll(res['data']);
    } catch (e) {
      print(e.toString());
    }
  }
}
