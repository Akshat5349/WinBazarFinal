import 'package:azmatka/app/modules/home/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainDrawerController extends GetxController {
  final userData = {}.obs;
  final loading = false.obs;
  final name = ''.obs;
  final mobile = ''.obs;
  final image = ''.obs;
  @override
  void onInit() {
    super.onInit();
    profileApi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  var box = GetStorage();

  @override
  void onClose() {}
  profileApi() async {
    loading.value = true;
    try {
      var res = await ApiProvider().postRequest(
          temp: false,
          apiUrl: 'user/get_user_profile',
          token: '${box.read('token')}',
          data: {'token': box.read('token')});
      userData.addAll(res);
      name.value = res['name'];
      mobile.value = res['mobile_number'];
      image.value = res['image'];
    } catch (e) {
      print(e.toString());
    }
    loading.value = false;
  }
}
