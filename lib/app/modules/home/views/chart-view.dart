import 'package:azmatka/app/modules/home/controllers/chart_controller.dart';
import 'package:azmatka/constants/values.dart';

class ChartView extends GetView<ChartController> {
  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ChartController());
    return Scaffold(
      backgroundColor: AppColors.primaryColorback,
      appBar: AppBar(
        title: Text('${controller.market_name} Result Chart'),
        centerTitle: false,
      ),
      body: Obx(() => controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
                  child: Column(
                    children: List.generate(controller.resultChart.length, (i) {
                      return Column(children: [
                        IntrinsicHeight(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  controller.resultChart[i]['data'].length,
                                  (j) {
                                return SizedBox(
                                  width: (context.width - 30) / 7,
                                  child: CustomWidgets().chartCard(
                                      day: days[j],
                                      data: controller.resultChart[i]['data']
                                          [j]),
                                );
                              })),
                        ),
                        if (i <
                            controller.resultChart.length -
                                1) // Only add a SizedBox if it's not the last row
                          SizedBox(height: 6)
                      ]);
                    }),
                  )),
            )),
    );
  }
}
