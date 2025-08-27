import 'package:azmatka/constants/values.dart';

class StarlineController extends GetxController {
  final loading = false.obs;
  final market = [].obs;
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
  Future starlineApi() async {
    loading.value = true;
    try {
      var res = await ApiProvider()
          .getRequest(apiUrl: 'starline_games', token: box.read('token'));
      // print(res);
      market.clear();
      market.addAll(res);
      loading.value = false;
    } catch (e) {
      print(e.toString());
      loading.value = false;
    }
  }
}
