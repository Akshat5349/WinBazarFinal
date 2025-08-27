import 'package:azmatka/app/modules/home/controllers/winning_history_controller.dart';
import 'package:azmatka/constants/values.dart';

class WinningHistoryView extends GetView<WinningHistoryController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WinningHistoryController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Winning History '),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //  heightSpace10,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        containerDesign('Date'),
                        containerDesign('Name'),
                        containerDesign('Type'),
                        containerDesign('Status'),
                        //containerDesign('Number'),
                        //  containerDesign('Points'),
                        containerDesign('Win Points'),
                      ],
                    ),
                    heightSpace20,
                    Obx(() => controller.loading.value
                        ? CircularProgressIndicator()
                        : Column(
                            children: List.generate(
                                controller.historyData.length, (index) {
                            var item = controller.historyData[index];
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    containerDesign2(
                                        item['created_at'].toString(),
                                        style: BaseStyles.blackMedium14),
                                    containerDesign2(item['market_id']
                                            ['market_name']
                                        .toString()),
                                    containerDesign2(item['market_id']
                                            ['market_type']
                                        .toString()),

                                    containerDesign2(
                                        item['market_id']['status'].toString()),
                                    //containerDesign2(
                                    //  item['pred_num'].toString()),
                                    // containerDesign2(
                                    // item['tr_value'].toString()),
                                    containerDesign2(
                                        item['winning_amount'].toString()),
                                  ],
                                ),
                                SizedBox(
                                  width: Get.width * 1,
                                  child: Divider(
                                    color: Colors.black54,
                                    height: 20,
                                  ),
                                ),
                              ],
                            );
                          })))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container containerDesign(title) {
    return Container(
      alignment: Alignment.center,
      width: Get.width * 0.20,
      child: Text(
        title,
        style: BaseStyles.accentMedium18,
        textAlign: TextAlign.center,
      ),
    );
  }

  Container containerDesign2(title, {style}) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      width: Get.width * 0.20,
      child: Text(
        title,
        style: style ?? BaseStyles.accentMedium18,
        textAlign: TextAlign.center,
      ),
    );
  }
}
