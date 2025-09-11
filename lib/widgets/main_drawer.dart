import 'package:azmatka/app/modules/home/views/bank_details_view.dart';
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
      width: 280,
      child: Drawer(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                // Header section with gradient background
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Obx(
                    () => Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                            Get.to(() => ProfileView());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.whiteColor,
                                width: 2,
                              ),
                            ),
                            child: controller.image.value != ''
                                ? CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(
                                        '${BASE_URL_image2}${controller.image.value}'))
                                : CircleAvatar(
                                    radius: 35,
                                    backgroundColor: AppColors.lightBlue,
                                    backgroundImage:
                                        AssetImage(ImagePath.LOGO)),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${controller.name.value}",
                                  style: BaseStyles.whiteMedium18),
                              SizedBox(height: 4),
                              Text("${controller.mobile.value}",
                                  style: BaseStyles.whiteMedium16.copyWith(
                                    color:
                                        AppColors.whiteColor.withOpacity(0.9),
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Menu items section
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    children: [
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
                          ? info(
                              title: DrawerDetails.bankDetails,
                              images: DrawerImages.bankDetails,
                              action: () {
                                Get.back();
                                Get.to(() => BankDetailsView());
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
                                      Get.to(() => BidHistoryView(),
                                          arguments: {
                                            'type': 'regular',
                                          });
                                    }),
                                info(
                                    title: DrawerDetails.winingHistory,
                                    images: DrawerImages.winingHistory,
                                    action: () {
                                      Get.back();
                                      Get.to(() => WinningHistoryView(),
                                          arguments: {
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Divider(
                          color: AppColors.lightGrey,
                          thickness: 1,
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
                            launchPlaystore(
                                Strings.settings[0].appLink.toString());
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

info({required title, required images, required action}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: AppColors.surfaceColor,
    ),
    child: ListTile(
      onTap: action,
      horizontalTitleGap: 12,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(
          images,
          width: 20,
          height: 20,
          color: AppColors.primaryColor,
        ),
      ),
      title: Text(
        title,
        style: BaseStyles.accentMedium18.copyWith(
          color: AppColors.blackColor,
          fontSize: 16,
        ),
      ),
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
