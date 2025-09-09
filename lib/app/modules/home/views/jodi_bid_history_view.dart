import 'package:azmatka/app/modules/home/controllers/jodi_bid_history_controller.dart';
import 'package:azmatka/constants/values.dart';

class JodiBidHistoryView extends GetView<JodiBidHistoryController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => JodiBidHistoryController());

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Bid History'),
          centerTitle: false,
        ),
        body: Obx(
          () => controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : controller.historyData.length == 0
                  ? Center(child: Text('No Bid Placed'))
                  : ListView.builder(
                      itemCount: controller.historyData.length,
                      padding: EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        var item = controller.historyData[index];
                        return Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Container(
                            width: Get.width,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white12,
                                      blurRadius: 3,
                                      spreadRadius: 3),
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.containsKey('starline_market_id')
                                          ? item['starline_market_id']
                                              ['market_name']
                                          : item.containsKey('mumbai_market_id')
                                              ? item['mumbai_market_id']
                                                  ['market_name']
                                              : item.containsKey(
                                                      'delhi_market_id')
                                                  ? item['delhi_market_id']
                                                      ['market_name']
                                                  : item['market_id']
                                                      ['market_name'],
                                      style: BaseStyles.blackMedium20,
                                    ),
                                    Text(
                                      item['session'].toString(),
                                      style: BaseStyles.blackBold18,
                                    ),
                                  ],
                                ),
                                heightSpace5,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Number : ${item['number']}",
                                      style: BaseStyles.accentMedium14,
                                    ),
                                  ],
                                ),
                                heightSpace5,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text(
                                    //   "Session : ${item['session']}",
                                    //   style: BaseStyles.blackMedium14,
                                    // ),
                                  ],
                                ),
                                heightSpace5,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Date : ${item['date']}",
                                      style: BaseStyles.accentMedium14,
                                    ),
                                    Text(
                                      "₹ ${item['amount']}",
                                      style: BaseStyles.accentMedium14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ));
  }

  Container containerDesign(title) {
    return Container(
      alignment: Alignment.center,
      width: Get.width * 0.2,
      child: Text(title, style: BaseStyles.accentMedium18),
    );
  }

  Container containerDesign2(title, {style}) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      width: Get.width * 0.2,
      child: Text(title, style: style ?? BaseStyles.accentMedium14),
    );
  }
}
/*
 CustomWidgets().buildTextFormFieldWithLabel(
                darkMode: false,
                labelText: 'To Date',
                controller: controller.toDateContoller,
                hintText: 'Select Date',
                prefixIcon: IconButton(
                    onPressed: () {
                      showDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime.now(),
                        context: context,
                      ).then((pickedDate) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate!);
                        return controller.toDateContoller.text = formattedDate;
                      });
                    },
                    icon: Icon(
                      Icons.calendar_month,
             )
         )
    ),
 */
