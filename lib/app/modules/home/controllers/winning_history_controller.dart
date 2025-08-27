import 'package:azmatka/constants/values.dart';

class WinningHistoryController extends GetxController {
  final loading = false.obs;
  final historyData = [].obs;
  var type = Get.arguments['type'];
  @override
  void onInit() {
    super.onInit();
    winHistoryApi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  winHistoryApi() async {
    loading.value = true;
    try {
      var res = await ApiProvider().postRequest(
          temp: false,
          token: '${box.read('token')}',
          apiUrl: 'winning-history',
          data: {
            'dev_id': deviceId(),
            'app_id': appId(),
            'user_id': userId(),
            'type': type.toString(),
          });
      historyData.addAll(res['data']);
      loading.value = false;
    } catch (e) {
      print(e.toString());
      loading.value = false;
    }
  }
}
