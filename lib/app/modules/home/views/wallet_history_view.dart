import 'package:azmatka/app/modules/home/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WalletHistoryView extends GetView<WalletController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet History'),
        centerTitle: false,
      ),
      body: Obx(
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
    );
  }
}
