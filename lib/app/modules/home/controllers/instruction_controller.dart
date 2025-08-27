import 'package:get/get.dart';
import 'package:azmatka/app/modules/home/providers/api_provider.dart';
import 'package:get_storage/get_storage.dart';

class InstructionController extends GetxController {
  final data = {}.obs;
  final loading = false.obs;
  @override
  void onInit() {
    super.onInit();
    instructionApi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  instructionApi() async {
    loading.value = true;
    var box = GetStorage();
    try {
      var res = await ApiProvider()
          .getRequest(apiUrl: 'aboutus', token: box.read('token'));
      print(res);
      data.addAll(res[0]);
      loading.value = false;
    } catch (e) {
      print(e.toString());
      loading.value = false;
    }
  }
}
