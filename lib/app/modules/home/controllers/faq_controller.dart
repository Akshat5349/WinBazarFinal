
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../constants/values.dart';

class FaqController extends GetxController {
  TextEditingController marketContoller = TextEditingController();
  final Completer<WebViewController> webController =
      Completer<WebViewController>();
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
}
