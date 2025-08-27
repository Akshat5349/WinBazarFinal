import 'package:azmatka/app/modules/home/controllers/add_bank_controller.dart';
import 'package:azmatka/constants/values.dart';

class AddBankView extends GetView<AddBankController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddBankController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        title: Text('Bank Detail',style: TextStyle(color:Colors.white),),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            heightSpace40,
            design(
                image: IconPath.bank, title: 'Add Bank Detail', ontap: () {}),
            heightSpace40,
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  CustomWidgets().buildTextFormFieldWithLabel(
                    darkMode: false,
                    labelText: 'Account No.',
                    controller: controller.accountNoController,
                    keyboardType: TextInputType.number,
                    hintText: 'Enter Account Number',
                  ),
                  heightSpace20,
                  CustomWidgets().buildTextFormFieldWithLabel(
                    darkMode: false,
                    labelText: 'Bank Name',
                    controller: controller.bankNameController,
                    hintText: 'Enter Bank Name',
                  ),
                  heightSpace20,
                  CustomWidgets().buildTextFormFieldWithLabel(
                    darkMode: false,
                    labelText: 'IFSC Code',
                    controller: controller.ifscCodeController,
                    hintText: 'Enter IFSC Code',
                  ),
                  heightSpace20,
                  CustomWidgets().buildTextFormFieldWithLabel(
                    darkMode: false,
                    labelText: 'A/C Holder',
                    controller: controller.accountHolderController,
                    hintText: 'Enter A/C Holder',
                  ),
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
      ),
    );
  }

  Widget design({required image, required title, Function()? ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(15),
        color: AppColors.primaryColor,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Image.asset(
                image,
                height: 35,
                width: 35,
                fit: BoxFit.fill,
              ),
            ),
            widthSpace10,
            Text(title, style: BaseStyles.whiteMedium18)
          ],
        ),
      ),
    );
  }
}
