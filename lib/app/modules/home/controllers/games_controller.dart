import 'package:azmatka/constants/values.dart';

class GamesController extends GetxController {
  var id = Get.arguments['id'];
  var title = Get.arguments['name'];
  var type = Get.arguments['type'];
  var marketType = Get.arguments['market_type'];
  var item = Get.arguments['item'];
  var open = Get.arguments['open'];
  var close = Get.arguments['close'];
  final gameType = [].obs;
  final loading = false.obs;
  @override
  void onInit() {
    super.onInit();
    gameTypeApi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  gameTypeApi() async {
    loading.value = true;
    try {
      var res = await ApiProvider().getRequest(
          apiUrl: 'game_types', token: 'Bearer ${box.read('token')}');
      gameType.addAll(res);
    } catch (e) {
      print(e.toString());
    }
    loading.value = false;
  }
}
