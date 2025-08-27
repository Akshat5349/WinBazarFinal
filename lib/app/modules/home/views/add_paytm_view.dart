import 'package:azmatka/app/modules/home/controllers/add_paytm_controller.dart';
import 'package:azmatka/constants/values.dart';

class AddPaytmView extends GetView<AddPaytmController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddPaytmController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ${controller.title} No.'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          heightSpace40,
          heightSpace40,
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                CustomWidgets().buildTextFormFieldWithLabel(
                  darkMode: false,
                  labelText: '${controller.title} No.',
                  hintText: 'Enter ${controller.title} Number',
                  controller: controller.mobileController,
                  keyboardType: TextInputType.number,
                ),
                heightSpace20,
                heightSpace40,
                CustomWidgets().buildMaterialBtn(
                    text: 'Save',
                    onPressed: () {
                      controller.addBankApi();
                    },
                    radius: 10,
                    color: AppColors.primaryColor)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
