import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/services/notification_service.dart';
import 'app/routes/app_pages.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize GetStorage
    await GetStorage.init();
    print('✅ GetStorage initialized');
  } catch (e) {
    print('❌ GetStorage initialization error: $e');
  }

  try {
    // Initialize Firebase
    await Firebase.initializeApp();
    print('✅ Firebase initialized');
  } catch (e) {
    print('❌ Firebase initialization error: $e');
  }

  try {
    // Initialize Notification Service
    await Get.putAsync(() => NotificationService().init());
    print('✅ NotificationService initialized');
  } catch (e) {
    print('❌ NotificationService initialization error: $e');
  }

  runApp(
    GetMaterialApp(
      title: "Royal",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.whiteColor,
        cardColor: AppColors.cardColor,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: AppColors.whiteColor),
            titleTextStyle: BaseStyles.whiteMedium20,
            backgroundColor: AppColors.primaryColor,
            elevation: 2,
            shadowColor: AppColors.lightGrey),
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryColor,
          secondary: AppColors.pinkColor,
          background: AppColors.whiteColor,
          surface: AppColors.cardColor,
          error: AppColors.errorColor,
        ),
        dividerColor: AppColors.dividerColor,
      ),
      onInit: () async {
        try {
          var box = GetStorage();
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

          // Platform-specific device info with error handling
          try {
            if (Platform.isAndroid) {
              AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
              box.write('device_id', androidInfo.id);
              box.write('device_name', androidInfo.brand);
              box.write('device_model', androidInfo.model);
              print('✅ Android device info saved');
            } else if (Platform.isIOS) {
              IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
              box.write('device_id', iosInfo.identifierForVendor);
              box.write('device_name', 'Apple');
              box.write('device_model', iosInfo.model);
              print('✅ iOS device info saved');
            }
          } catch (e) {
            print('❌ Device info error: $e');
            // Set default values if device info fails
            box.write('device_id', 'unknown');
            box.write('device_name', 'unknown');
            box.write('device_model', 'unknown');
          }
        } catch (e) {
          print('❌ OnInit error: $e');
        }
      },
    ),
  );
}
