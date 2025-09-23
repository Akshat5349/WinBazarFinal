import 'package:azmatka/app/Models/slider_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/share.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
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
    print(Strings.settings[0].popupHeading);
    print(Strings.settings[0].popupMsg);
    super.onInit();
    // Check and show daily popup after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAndShowDailyPopup();
    });
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

  // Check if popup should be shown today and show it
  void checkAndShowDailyPopup() {
    try {
      String today = DateTime.now()
          .toIso8601String()
          .split('T')[0]; // Get YYYY-MM-DD format
      String? lastPopupDate = box.read('last_popup_date');

      // Show popup if it hasn't been shown today
      if (lastPopupDate != today) {
        // Check if settings are available and have popup content
        if (Strings.settings.isNotEmpty &&
            Strings.settings[0].popupHeading != null &&
            Strings.settings[0].popupHeading!.isNotEmpty &&
            Strings.settings[0].popupMsg != null &&
            Strings.settings[0].popupMsg!.isNotEmpty) {
          showDailyPopup();
          // Save today's date to prevent showing again today
          box.write('last_popup_date', today);
        }
      }
    } catch (e) {
      print('Error checking daily popup: ${e.toString()}');
    }
  }

  // Show the daily popup with settings content
  void showDailyPopup() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.campaign,
              color: AppColors.primaryColor,
              size: 24,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                Strings.settings[0].popupHeading ?? 'Announcement',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Cross icon at top right
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.close,
                color: Colors.grey[600],
                size: 24,
              ),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.settings[0].popupMsg ?? 'Welcome to Royal!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
        // Remove the actions completely
        actions: [],
        actionsPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 24),
      ),
      barrierDismissible: true,
    );
  }

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
          .getRequest(apiUrl: 'games_list', token: box.read('token'));
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
