import 'package:azmatka/constants/values.dart';
import 'package:get_storage/get_storage.dart';

class JodiBidHistoryController extends GetxController {
  final loading = false.obs;
  final historyData = [].obs;
  var type = Get.arguments['type'];
  @override
  void onInit() {
    super.onInit();
    historyApi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  var box = GetStorage();

  historyApi() async {
    loading.value = true;
    try {
      var res = await ApiProvider()
          .getRequest(apiUrl: 'jodi-bid-history', token: box.read('token'));

      historyData.addAll(res['data']);
      loading.value = false;
    } catch (e) {
      print(e.toString());
      loading.value = false;
    }
  }
}
