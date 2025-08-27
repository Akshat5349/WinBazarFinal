import 'package:flutter_html/flutter_html.dart';
import 'package:azmatka/app/modules/home/controllers/notice_controller.dart';
import 'package:azmatka/constants/values.dart';

class NoticeView extends GetView<NoticeController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NoticeController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Notice'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => controller.loading.value
              ? CircularProgressIndicator()
              : Html(
                  data: controller.data['description'].toString(),
                  style: {
                    'body': Style(
                      fontSize: FontSize(18),
                    ),
                  },
                ),
        ),
      ),
    );
  }
}
/*
SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dear Player', style: BaseStyles.goldMedium18),
              heightSpace30,
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Withdrawal',
                  style: BaseStyles.purpleMedium18
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              heightSpace30,
              Text(
                'Withdrawal will be accepted from 11.00 am till 01.00 pm and will be credited withhin 15 to 30 minutes',
                style: BaseStyles.blackMedium16,
                textAlign: TextAlign.center,
              ),
              heightSpace30,
              Container(
                width: Get.width,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImagePath.whatsapp,
                      height: 20,
                    ),
                    widthSpace10,
                    Text(
                      '9923456789',
                      style: BaseStyles.goldMedium18,
                    ),
                  ],
                ),
              ),
              heightSpace30,
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Notice',
                  style: BaseStyles.purpleMedium18
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              heightSpace30,
              Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  textAlign: TextAlign.center,
                  style: BaseStyles.blackMedium16),
            ],
          ),
        ),
      ),
      */