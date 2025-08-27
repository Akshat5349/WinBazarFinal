import 'package:azmatka/constants/values.dart';

class NoticeController extends GetxController {
  final data = {}.obs;
  final loading = false.obs;
  @override
  void onInit() {
    super.onInit();
    noticeApi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  noticeApi() async {
    loading.value = true;
    try {
      var res = await ApiProvider().getRequest(apiUrl: 'notice.php');
      data.addAll(res);
      loading.value = false;
    } catch (e) {
      print(e.toString());
      loading.value = false;
    }
  }
}
