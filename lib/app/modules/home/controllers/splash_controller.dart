import 'package:get_storage/get_storage.dart';
import '../../../../constants/values.dart';
import '../../../Models/setting_model.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation1;
  var box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation1 = Tween<double>(begin: 100.0, end: 100.0).animate(controller);
    controller.forward();
    splash();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  maintenanceApi() async {}
  splash() async {
    Future.delayed(Duration(seconds: 1), () async {

      try {
      var res = await ApiProvider().getRequest3(
          apiUrl: 'settings/list');
      Strings.settings.clear();
      if (res != null) {
        for (int i = 0; i < res['data'].length; i++) {
          Strings.settings.add(SettingModel.fromJson(res['data'][i]));
        }

      }

    } catch (e) {
      print(e.toString());
    }



      if ((box.read('token') != null||box.read('token')!='') && box.read('is_registered') == 1) {
        if (box.read('isClone') == true) {
          // Get.offAll(() => ProductView());
        } else {
          Get.offAllNamed('/home');
        }
      }
      // else if (box.read('token') != null && box.read('is_registered') == 0) {
      //   Get.offAll(SignupView());
      // }
      else {
        Get.offAllNamed('/login');
      }
    });
    //   try {
    //     var res = await ApiProvider().getRequest(apiUrl: 'app_maintance.php');
    //     print(res);
    //     if (res['is_app_maintainance'].toString() == '1') {
    //       Get.off(() => userId() == '' ? LoginView() : HomeView());
    //     } else {
    //       Get.off(() => userId() == '' ? LoginView() : ProductView());
    //     }
    //   } catch (e) {
    //     print(e.toString());
    //   }
    // });
    
  }
}
