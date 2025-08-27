import 'package:azmatka/app/modules/home/controllers/wallet_controller.dart';
import 'package:azmatka/constants/values.dart';
import 'package:intl/intl.dart';

class WalletView extends GetView<WalletController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletController());
    controller.walletApi();
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   width: Get.width,
            //   padding: EdgeInsets.all(20),
            //   child: Obx(
            //     () => Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Row(
            //           children: [
            //             Icon(
            //               Icons.account_balance_wallet_outlined,
            //               color: AppColors.primaryAccentColor,
            //               size: 40,
            //             ),
            //             widthSpace5,
            //             Text('WALLET BALANCE',
            //                 style: BaseStyles.purpleMedium18),
            //           ],
            //         ),
            //         Text(controller.balance.toString(),
            //             style: BaseStyles.purpleMedium18)
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              width: Get.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryAccentColor,
              ),
              child: Column(
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     Get.to(() => WithdrawView());
                  //   },
                  //   child: Container(
                  //     width: Get.width,
                  //     child: design(
                  //         image: IconPath.rupees, title: 'Withdraw Funds'),
                  //   ),
                  // ),
                  // heightSpace20,
                  // InkWell(
                  //   onTap: () {
                  //    Get.to(() => PaymentScreen());
                  //   },
                  //   child: design(
                  //       image: DrawerImages.pointManagement,
                  //       title: 'Add Funds'),
                  // ),
                  // heightSpace20,
                  InkWell(
                    onTap: () {
                     // Get.to(() => WalletHistoryView());
                    },
                    child: Container(
                      width: Get.width,
                      child: design(
                          image: IconPath.history,
                          title: 'Funds Request History'),
                    ),
                  ),
                  
                  //heightSpace20,
                ],
              ),
            ),
            Obx(
        () => controller.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                padding: EdgeInsets.all(15),
                itemCount: controller.walletHistory.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = controller.walletHistory[index];
                  return ListTile(
                    title: Text(
                      item['amount'].toString(),
                    ),
                    subtitle: Text(DateFormat("yyyy-MM-dd hh:mm:ss")
                        .parse(DateTime.fromMillisecondsSinceEpoch(
                                int.parse(item['created_at']))
                            .toString())
                        .toString()),
                    trailing: Text(item['transaction_type'].toString()),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.black,
                  );
                },
              ),
      ),
          ],
        ),
      ),
    );
  }

  Widget design({required image, required title}) {
    return Row(
      children: [
        Image.asset(
          image,
          height: 30,
          fit: BoxFit.fill,
        ),
        widthSpace10,
        Text(title, style: BaseStyles.whiteMedium18)
      ],
    );
  }
}
