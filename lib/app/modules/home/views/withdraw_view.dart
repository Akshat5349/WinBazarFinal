import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:azmatka/app/modules/home/controllers/withdraw_controller.dart';
import 'package:azmatka/constants/values.dart';

class WithdrawView extends GetView<WithdrawController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WithdrawController());
    return Scaffold(
      backgroundColor: Color(0xFFE6F6FF),
      appBar: AppBar(
        title: Text('Withdraw Points'),
        centerTitle: true,
        backgroundColor: AppColors.primaryAccentColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Notice Box
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: Color(0xFFBFE3FA),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        '!!Withdraw Notice!!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.blueColor,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        Strings.settings[0].withdrawScreenMsg.toString(),
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 15, color: AppColors.blueColor),
                      ),
                    ],
                  ),
                ),
                // Payment Method Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _iconWithLabel('assets/icons/phonepe.png', 'PhonePe'),
                    _iconWithLabel('assets/icons/paytm.png', 'PayTm'),
                    _iconWithLabel(IconPath.google, 'GPay'),
                    _iconWithLabel('assets/icons/bank.png', 'Bank'),
                  ],
                ),
                SizedBox(height: 18),
                // Green Info Bar

                // Points Input
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: controller.pointContoller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.currency_rupee,
                          color: AppColors.primaryColor),
                      border: InputBorder.none,
                      hintText: 'Enter Points',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                // Payment Method Dropdown
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: controller.selectvalue.value,
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: [
                        DropdownMenuItem(value: 1, child: Text('Bank')),
                        DropdownMenuItem(value: 2, child: Text('Paytm')),
                        DropdownMenuItem(value: 3, child: Text('PhonePe')),
                        DropdownMenuItem(value: 4, child: Text('Google Pay')),
                      ],
                      onChanged: (val) {
                        if (val != null) controller.selectvalue.value = val;
                      },
                      hint: Text('Select Payment Method'),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    onPressed: () {
                      if (controller.pointContoller.text.length <
                          Strings.settings[0].minimumTransfer!.length) {
                        toast(
                            'Minimum amount is ${Strings.settings[0].minimumTransfer} Rs');
                      } else if (controller.pointContoller.text.length >
                          Strings.settings[0].maximumTransfer!.length) {
                        toast(
                            'Maximum amount is ${Strings.settings[0].maximumTransfer} Rs');
                      } else {
                        controller.withdrawApi();
                      }
                    },
                    child: Text('SUBMIT',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                SizedBox(height: 20),
                // Bottom Notice
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: Text(
                    Strings.settings[0].withdrawScreenMsg.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconWithLabel(String asset, String label) {
    return Column(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(asset, fit: BoxFit.contain),
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 13)),
      ],
    );
  }
}
