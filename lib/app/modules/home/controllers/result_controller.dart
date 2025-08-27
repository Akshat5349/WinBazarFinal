import 'package:azmatka/constants/values.dart';
import 'package:get_storage/get_storage.dart';

class ResultController extends GetxController {
  final loading = false.obs;
  final result = [].obs;
  var type = Get.arguments['type'];
  @override
  void onInit() {
    super.onInit();
    resultApi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  var box = GetStorage();

  resultApi() async {
    loading.value = true;
    try {
      var res = await ApiProvider()
          .getRequest(apiUrl: 'result', token: box.read('token'));

      result.addAll(res['data']);
      loading.value = false;
    } catch (e) {
      print(e.toString());
      loading.value = false;
    }
  }
}
