import 'package:azmatka/constants/values.dart';

import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ResultController());

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Result'),
          centerTitle: false,
        ),
        body: Obx(
          () => controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : controller.result.length == 0
                  ? Center(child: Text('No Data'))
                  : ListView.builder(
                      itemCount: controller.result.length,
                      padding: EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        var item = controller.result[index];
                        //print(item['game_number_id']);
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
                                    //  Text(item['amount'].toString()),
                                    item['market_id'] == null
                                        ? Text("")
                                        : Text(
                                            item['market_id']['market_name'],
                                            style: BaseStyles.blackMedium20,
                                          ),
                                    item['game_type_id'] == null
                                        ? Text("")
                                        : Text(
                                            item['game_type_id']['type']
                                                .toString(),
                                            style: BaseStyles.blackMedium16,
                                          ),
                                  ],
                                ),
                                heightSpace5,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Result : ${item['result_number']}",
                                      style: BaseStyles.blackMedium14,
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
                                      style: BaseStyles.blackMedium14,
                                    ),
                                    // Text(
                                    //   "₹ ${item['amount']}",
                                    //   style: BaseStyles.blackMedium14,
                                    // ),
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
      child: Text(title, style: BaseStyles.primaryMedium18),
    );
  }

  Container containerDesign2(title, {style}) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      width: Get.width * 0.2,
      child: Text(title, style: style ?? BaseStyles.blackMedium14),
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
