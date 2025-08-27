import 'package:get_storage/get_storage.dart';
import 'package:azmatka/app/modules/home/auth/views/login_view.dart';
import 'package:azmatka/app/modules/home/controllers/main_drawer_controller.dart';
import 'package:azmatka/app/modules/home/views/new_password_view.dart';
import 'package:azmatka/app/modules/home/views/profile_view.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/share.dart';

class ProductDrawerView extends GetView<MainDrawerController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MainDrawerController());
    var box = GetStorage();
    return SizedBox(
      width: 250,
      child: Drawer(
        backgroundColor: AppColors.primaryColor,
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 25),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                          Get.to(() => ProfileView());
                        },
                        child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.lightBlue,
                            child: Image.asset(ImagePath.LOGO)),
                      ),
                      heightSpace10,
                      Text(userName(), style: BaseStyles.whiteMedium18),
                      heightSpace5,
                      Text(mobileNumber(), style: BaseStyles.whiteMedium18),
                    ],
                  ),
                ),
                heightSpace20,
                info(
                    title: DrawerDetails.dashboard,
                    images: DrawerImages.dashboard,
                    action: () {
                      Get.back();
                    }),
                info(
                    title: 'My Order',
                    images: DrawerImages.bid,
                    action: () {
                      Get.back();
                    }),
                info(
                    title: 'Cart',
                    images: DrawerImages.bid,
                    action: () {
                      Get.back();
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                ),
                info(
                    title: DrawerDetails.rating,
                    images: DrawerImages.rate,
                    action: () {
                      Get.back();
                      launchPlaystore(
                          'https://play.google.com/store/apps/details?id=com.rajmatkaofficialapp.app');
                    }),
                info(
                    title: DrawerDetails.newPassword,
                    images: DrawerImages.newpassword,
                    action: () {
                      Get.back();
                      Get.to(() => NewPasswordView());
                    }),
                info(
                    title: DrawerDetails.logout,
                    images: DrawerImages.logout,
                    action: () {
                      box.erase();
                      Get.offAll(() => LoginView());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  info({required title, required images, required action}) {
    return ListTile(
      onTap: action,
      horizontalTitleGap: 0,
      leading: Image.asset(
        images,
        width: 30,
        height: 30,
      ),
      title: Text(title, style: BaseStyles.whiteMedium18),
      dense: true,
    );
  }
}
