import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final count = 1.obs;
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
  increment() {
    count.value++;
  }

  decrement() {
    count.value--;
  }
}
