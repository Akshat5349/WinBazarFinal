import 'package:azmatka/constants/values.dart';

import '../controllers/faq_controller.dart';

class SelectMarketView extends GetView<FaqController> {
    
  final List markets = [
    'Milan Morning',
    'Kalyan Night',
    'Starline ',
    'Milan Night',
  'Rajdhani Day',
  'Rajdhani Night',
  'Supreme Day',
  'Supreme Night',
  'Time Bazar',
  'Main Bazar',
  'Kuber Morning',
  'Kuber Night'
  ];

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FaqController());
    var item2 = Get.find<FaqController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Market'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: markets.length,
                  itemBuilder: (context, index) {
                    var item = markets[index];
                    // print(controller.digit.length);
                    return GestureDetector(
                      onTap: () {
                        item2.marketContoller.text = item.toString();

                        Get.back();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54)),
                        child: Text(
                          item.toString(),
                          style: BaseStyles.blackBold18,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
  }
}
