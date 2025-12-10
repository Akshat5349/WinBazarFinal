import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_storage/get_storage.dart';
import 'package:azmatka/constants/values.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      title: "Kalyan365",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF03045e),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: AppColors.whiteColor),
              titleTextStyle: BaseStyles.whiteMedium20,
              backgroundColor: AppColors.primaryAccentColor,
              elevation: 0)),
      onInit: () async {
        var box = GetStorage();
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        box.write('device_id', androidInfo.device.toString());
        box.write('device_name', androidInfo.brand.toString());
        box.write('device_model', androidInfo.model.toString());
      },
    ),
  );
}
