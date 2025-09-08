import 'package:azmatka/app/modules/home/controllers/wallet_controller.dart';
import 'package:azmatka/constants/values.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Obx(
        () => controller.loading.value
            ? Center(child: CircularProgressIndicator())
            : CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                slivers: [
                  // Header section with wallet options
                  SliverToBoxAdapter(
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccentColor,
                      ),
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                  ),
                  // Wallet history list
                  controller.walletHistory.isEmpty
                      ? SliverToBoxAdapter(
                          child: Container(
                            height: 200,
                            child: Center(
                              child: Text(
                                'No transaction history found',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              var item = controller.walletHistory[index];
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      title: Text(
                                        '₹${item['amount'].toString()}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: item['transaction_type']
                                                      .toString()
                                                      .toLowerCase() ==
                                                  'credit'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      subtitle: Text(
                                        DateFormat("MMM dd, yyyy hh:mm a")
                                            .format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(item['created_at']),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      trailing: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: item['transaction_type']
                                                      .toString()
                                                      .toLowerCase() ==
                                                  'credit'
                                              ? Colors.green.withOpacity(0.1)
                                              : Colors.red.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: item['transaction_type']
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'credit'
                                                ? Colors.green
                                                : Colors.red,
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          item['transaction_type']
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: item['transaction_type']
                                                        .toString()
                                                        .toLowerCase() ==
                                                    'credit'
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (index <
                                        controller.walletHistory.length - 1)
                                      Divider(
                                        color: Colors.grey[300],
                                        thickness: 1,
                                        indent: 16,
                                        endIndent: 16,
                                      ),
                                  ],
                                ),
                              );
                            },
                            childCount: controller.walletHistory.length,
                          ),
                        ),
                  // Add some bottom padding
                  SliverToBoxAdapter(
                    child: SizedBox(height: 20),
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
