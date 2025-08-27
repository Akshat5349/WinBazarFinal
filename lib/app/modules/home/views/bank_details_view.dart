import 'package:azmatka/app/modules/home/views/add_bank_view.dart';
import 'package:azmatka/app/modules/home/views/add_paytm_view.dart';
import 'package:azmatka/constants/values.dart';

class BankDetailsView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Details'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          heightSpace20,
          design(
              image: IconPath.bank,
              title: 'Add Bank Detail',
              ontap: () {
                Get.to(
                  () => AddBankView(),
                );
              }),
          heightSpace10,
          design(
              image: IconPath.paytm,
              title: 'Add Paytm Number',
              ontap: () {
                Get.to(() => AddPaytmView(), arguments: {'title': 'Paytm'});
              }),
          heightSpace10,
          design(
              image: IconPath.google,
              title: 'Add Google Pay Number',
              ontap: () {
                Get.to(() => AddPaytmView(),
                    arguments: {'title': 'Google Pay'});
              }),
          heightSpace10,
          design(
              image: IconPath.phonepe,
              title: 'Add PhonePe Number',
              ontap: () {
                Get.to(() => AddPaytmView(), arguments: {'title': 'PhonePe'});
              }),
          heightSpace10,
        ],
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
