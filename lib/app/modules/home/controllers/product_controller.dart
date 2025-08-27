import 'package:azmatka/constants/values.dart';

class ProductController extends GetxController {
  final products = [].obs;
  final url = ''.obs;
  final loading = false.obs;
  @override
  void onInit() {
    super.onInit();
    productApi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  productApi() async {
    loading.value = true;
    try {
      var res = await ApiProvider()
          .getRequest(apiUrl: 'products', token: box.read('token'));
      products.addAll(res['data']);
      url.value = res['url'].toString();
      loading.value = false;
    } catch (e) {
      print(e);
      loading.value = false;
    }
  }
}
