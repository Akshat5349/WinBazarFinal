import 'package:azmatka/app/Models/slider_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/share.dart';

class GaliDisawarController extends GetxController {
  final loading = false.obs;
  final market = [].obs;
  final userWallet = {}.obs;
  final resultData = [].obs;
  final homeLoading = true.obs;
  var box = GetStorage();
  final Sliders = <SliderModel>[].obs;

  final approve = ''.obs;

  // final banners = [
  //   "https://static.langimg.com/thumb/msid-65706850,imgsize-140009,width-540,height-405,resizemode-75/satta-matka-tips-65706850.jpg",
  // ];
  @override
  void onInit() {
    super.onInit();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showDownloadDialog();
    // });
  }

  @override
  void onReady() async {
    super.onReady();
    homeLoading.value = true;
    await homeApi();
    await wallet();
    await sliders();
    // await settingApi();
    homeLoading.value = false;
  }

  @override
  void onClose() {}

  void showDownloadDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Download APK'),
        content: Text('Do you want to download the latest version of the APK?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
          MaterialButton(
            height: 45,
            onPressed: () {
              launchurl('https://onlineplaygame.in/assets/app/dhanlaxmi.apk');
              Get.back();
            },
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            elevation: 1,
            child: Text(
              "Download",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Acumin Pro',
                fontWeight: FontWeight.w700,
                color: AppColors.whiteColor,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future homeApi() async {
    try {
      loading.value = true;
      var res = await ApiProvider()
          .getRequest(apiUrl: 'jodi_games_list', token: box.read('token'));
      print(res.toString());
      market.clear();
      market.addAll(res['games']);
      market.sort((a, b) => (a['open_time']).compareTo(b['open_time']));
      approve.value = res['approved'].toString();

      loading.value = false;
    } catch (e) {
      print(e.toString());
    }
  }

  wallet() async {
    try {
      loading.value = true;
      var res = await ApiProvider().getRequest(
          apiUrl: 'user/get_user_wallet_details',
          token: 'Bearer ${box.read('token')}');

      userWallet.remove('wallet_balance');
      userWallet.addAll(res['data']);
      loading.value = false;
    } catch (e) {
      print(e.toString());
    }
  }

  sliders() async {
    try {
      var res = await ApiProvider()
          .getRequest2(apiUrl: 'slider', token: 'Bearer ${box.read('token')}');
      for (int i = 0; i < res.length; i++) {
        Sliders.add(SliderModel.fromJson(res[i]));
      }
      // userWallet.addAll(res['data']);
    } catch (e) {
      print(e.toString());
    }
  }

  resultHistory() async {
    loading.value = true;
    try {
      var res = await ApiProvider()
          .getRequest(apiUrl: 'result', token: 'Bearer ${box.read('token')}');
      resultData.addAll(res['data']);
      loading.value = false;
    } catch (e) {
      print(e.toString());
      loading.value = false;
    }
  }

  // settingApi() async {
  //   try {
  //     homeLoading.value=true;
  //     var res = await ApiProvider().getRequest3(
  //         apiUrl: 'settings/list', token: 'Bearer ${box.read('token')}');
  //     print(res['data']);
  //     Strings.settings.clear();
  //     if (res != null) {
  //       for (int i = 0; i < res['data'].length; i++) {
  //         Strings.settings.add(SettingModel.fromJson(res['data'][i]));
  //       }
  //     }
  //     homeLoading.value=false;

  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
