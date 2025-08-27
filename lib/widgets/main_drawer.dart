import 'package:azmatka/app/modules/home/views/privacy_and_policy_view.dart';
import 'package:azmatka/widgets/base_url.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:azmatka/app/modules/home/controllers/main_drawer_controller.dart';
import 'package:azmatka/app/modules/home/views/bid_history_view.dart';
import 'package:azmatka/app/modules/home/views/faq_view.dart';
import 'package:azmatka/app/modules/home/views/instruction_view.dart';
import 'package:azmatka/app/modules/home/views/profile_view.dart';
import 'package:azmatka/app/modules/home/views/wallet_view.dart';
import 'package:azmatka/app/modules/home/views/win_rate_view.dart';
import 'package:azmatka/app/modules/home/views/winning_history_view.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/share.dart';

import '../app/modules/home/views/result_view.dart';

class MainDrawer extends GetView<MainDrawerController> {
  MainDrawer({required this.approved});
  final approved;
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
                Obx(
                  () => Container(
                    padding: EdgeInsets.only(left: 25, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryAccentColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                            Get.to(() => ProfileView());
                          },
                          child: controller.image.value != ''
                              ? CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.lightBlue,
                                  backgroundImage: NetworkImage(
                                      '${BASE_URL_image2}${controller.image.value}'))
                              : CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.lightBlue,
                                  backgroundImage: AssetImage(ImagePath.LOGO)),
                        ),
                        heightSpace10,
                        Text("${controller.name.value}",
                            style: BaseStyles.whiteMedium18),
                        heightSpace5,
                        Text("${controller.mobile.value}",
                            style: BaseStyles.whiteMedium18),
                      ],
                    ),
                  ),
                ),
                heightSpace20,
                info(
                    title: DrawerDetails.dashboard,
                    images: DrawerImages.dashboard,
                    action: () {
                      Get.back();
                    }),
                approved == 'true'
                    ? info(
                        title: DrawerDetails.pointManagement,
                        images: DrawerImages.pointManagement,
                        action: () {
                          Get.back();
                          Get.to(() => WalletView());
                        })
                    : Container(),
                approved == 'true'
                    ? Column(
                        children: [
                          info(
                              title: DrawerDetails.result,
                              images: DrawerImages.result,
                              action: () {
                                Get.back();
                                Get.to(() => ResultView(), arguments: {
                                  'type': 'regular',
                                });
                              }),
                          info(
                              title: DrawerDetails.bidHistory,
                              images: DrawerImages.bid,
                              action: () {
                                Get.back();
                                Get.to(() => BidHistoryView(), arguments: {
                                  'type': 'regular',
                                });
                              }),
                          info(
                              title: DrawerDetails.winingHistory,
                              images: DrawerImages.winingHistory,
                              action: () {
                                Get.back();
                                Get.to(() => WinningHistoryView(), arguments: {
                                  'type': 'regular',
                                });
                              }),
                          // approved == 'true'?info(
                          //     title: DrawerDetails.bankDetails,
                          //     images: DrawerImages.bankDetails,
                          //     action: () {
                          //       Get.back();
                          //       Get.to(() => BankDetailsView());
                          //     }):Container(),
                          info(
                              title: DrawerDetails.winRate,
                              images: DrawerImages.winRate,
                              action: () {
                                Get.back();
                                Get.to(() => WinRateView());
                              }),
                        ],
                      )
                    : Container(),

                // info(
                //     title: DrawerDetails.notices,
                //     images: DrawerImages.notices,
                //     action: () {
                //       Get.back();
                //       Get.to(() => NoticeView());
                //     }),
                info(
                    title: 'About Us',
                    images: DrawerImages.instructions,
                    action: () {
                      Get.back();
                      Get.to(() => InstructionView());
                    }),
                info(
                    title: DrawerDetails.FAQ,
                    images: DrawerImages.faq,
                    action: () {
                      Get.back();
                      Get.to(() => FAQScreen());
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: AppColors.primaryAccentColor,
                    thickness: 2,
                  ),
                ),
                info(
                    title: DrawerDetails.shareApp,
                    images: DrawerImages.share,
                    action: () {
                      Share.share(Strings.settings[0].appLink.toString(),
                          subject: '');
                    }),
                info(
                    title: DrawerDetails.rating,
                    images: DrawerImages.rate,
                    action: () {
                      Get.back();
                      launchPlaystore(Strings.settings[0].appLink.toString());
                    }),
                info(
                    title: 'Privacy Policy',
                    images: DrawerImages.newpassword,
                    action: () {
                      Get.back();
                      Get.to(() => PrivacyPolicyScreen());
                    }),
                info(
                    title: DrawerDetails.logout,
                    images: DrawerImages.logout,
                    action: () {
                      box.erase();
                      Get.offAllNamed('/login');
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

info({required title, required images, required action}) {
  return ListTile(
    onTap: action,
    horizontalTitleGap: 10,
    leading: Image.asset(
      images,
      width: 30,
      height: 30,
    ),
    title: Text(title, style: BaseStyles.accentMedium18),
    dense: true,
  );
}
