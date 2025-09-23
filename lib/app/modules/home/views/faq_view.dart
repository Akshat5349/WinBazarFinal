import 'package:azmatka/constants/values.dart';

import '../controllers/faq_controller.dart';
import 'select_market_view.dart';

class FAQScreen extends GetView<FaqController> {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FaqController());
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          ListTile(
            title: Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Introduction to Royal',
                  textAlign: TextAlign.center,
                )),
            subtitle: Text(
              'Royal is your ultimate destination for everything related to the fascinating world of the Satta Matka. As the Royal is a leading authority in the realm of Matka Games, this is your Go-To Platform for any reliable information along with accurate Matka Results and expert guidance obviously. Whether you are a pro or a newcomer player the comprehensive collection of resources such as Kalyan Matka, Matka Result, and Mumbai Matka, will provide you with the thrilling and immersive experience. Join us along and we will embark on this captivating adventure, where every matka number, matka chart, and matka games hold the potential to unlock fortunes.',
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              CustomWidgets().buildTextFormFieldWithLabel(
                  darkMode: false,
                  hintText: 'Select Market',
                  controller: controller.marketContoller,
                  readOnly: true,
                  ontap: () {
                    Get.to(() => SelectMarketView());
                  }),
              heightSpace20,
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryAccentColor),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  minLines: 5,
                  maxLines: 5,
                  decoration: InputDecoration(
                    fillColor: AppColors.lightGrey,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter your result.',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              heightSpace20,
              CustomWidgets().buildMaterialBtn(
                  text: 'SUBMIT',
                  onPressed: () {
                    Get.back();
                  },
                  color: AppColors.pinkColor,
                  radius: 12)
            ]),
          )
        ],
      ),
    );
  }
}
