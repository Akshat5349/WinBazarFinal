import 'dart:convert';
import 'dart:io';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'dart:typed_data';
// import 'package:image_picker_web/image_picker_web.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../../../../widgets/base_url.dart';

import '../../../../widgets/share.dart';

var box = GetStorage();

Future<bool> sendPaymentProof({
  required String apiUrl,
  required String amount,
  File? imageFile,
}) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$BASE_URL$apiUrl'),
    );
    request.headers.addAll({
      'Authorization': '${box.read('token')}',
      'Content-Type': 'multipart/form-data',
      "Access-Control-Allow-Origin": "*"
    });
    request.fields['amount'] = amount;
    request.fields['refNo'] = '';

    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType:
              MediaType.parse(lookupMimeType(imageFile.path) ?? "image/jpeg"),
        ),
      );
    } else {
      // toast("Image not selected");
      // return false;
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      var res = await http.Response.fromStream(response);
      var data = jsonDecode(res.body);

      toast(data["message"].toString());
      return true;
    } else {
      toast(
          "Failed to upload payment proof. Status Code: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("Error submitting payment: $e");
    return false;
  }
}

class PaymentScreen extends StatefulWidget {
  String order_id = "";

  Future<String> pay({
    required String amount,
  }) async {
    try {
      var res = await ApiProvider().postRequest2(
          apiUrl: "user/autopay",
          data: {
            'amount': amount,
          },
          token: await box.read('token'));
      res = jsonDecode(res);
      order_id = res['orderId'];
      return res['payment_url'];
      // return res;
    } catch (e) {
      print("Error submitting payment: $e");
      return "#";
    }
  }

  Future<void> checkPaymentStatus({required String amount}) async {
    try {
      var res = await ApiProvider().postRequest2(
          apiUrl: "user/check_payment_status",
          data: {'amount': amount, 'order_id': order_id},
          token: await box.read('token'));
      res = jsonDecode(res);
      if (res['status'] == "success") {
        toast("Payment Successful");
      } else {
        toast(
            "Request is generated, Your Credit Request will be processed soon.");
      }
    } catch (e) {
      toast("Error checking payment status: $e");
    }
  }

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController refController = TextEditingController();
  // Uint8List? _selectedImage;
  File? _selectedImage;
  bool isLoading = false;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (widget.order_id != "") {
        await widget.checkPaymentStatus(amount: amountController.text);
        Get.offAllNamed('/home');
      }
    }
  }

  dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // Function to pick image (for Flutter Web)
  // Future<void> _pickImage() async {
  //   Uint8List? pickedImage = await ImagePickerWeb.getImageAsBytes();
  //   if (pickedImage != null) {
  //     setState(() {
  //       _selectedImage = pickedImage;
  //     });
  //   }
  // }

  // Function to pick image (Cross-platform)
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Method to build quick add amount buttons
  Widget _buildQuickAddButton(String amount) {
    return GestureDetector(
      onTap: () {
        // Add haptic feedback
        HapticFeedback.selectionClick();
        // Set the amount in the text controller
        amountController.text = amount;
      },
      child: Container(
        width: Get.width * 0.26,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFd4af37),
              Color(0xFFf4d03f),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFd4af37).withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: AppColors.primaryColor,
              size: 20,
            ),
            SizedBox(height: 4),
            Text(
              "₹$amount",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Funds'),
        backgroundColor: AppColors.primaryColorback,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primaryAccentColor,
                  indicatorColor: AppColors.primaryAccentColor,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "AutoPay"),
                    Tab(text: "Manual Payment"),
                  ],
                ),
                SizedBox(
                    height: Get.height,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Column(
                          children: [
                            heightSpace20,
                            CustomWidgets().buildTextFormFieldWithLabel(
                                darkMode: false,
                                labelText: "Enter Points",
                                controller: amountController,
                                hintText: "Enter Points",
                                keyboardType: TextInputType.number),
                            heightSpace10,
                            // Quick Add Amount Buttons
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Quick Add",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildQuickAddButton("300"),
                                      _buildQuickAddButton("500"),
                                      _buildQuickAddButton("1000"),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildQuickAddButton("2000"),
                                      _buildQuickAddButton("5000"),
                                      _buildQuickAddButton("10000"),
                                      Container(
                                          width: Get.width *
                                              0.28), // Empty space for alignment
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            heightSpace20,
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.primaryColorback),
                                onPressed: () async {
                                  // if (refController.text.isEmpty) {
                                  //   toast("Please enter the Ref No.");
                                  //   return;
                                  // }
                                  // if (_selectedImage == null) {
                                  //    toast("Please upload payment proof.");
                                  //   return;
                                  // }
                                  if (int.parse(Strings
                                          .settings[0].minDepositRate
                                          .toString()) >
                                      int.parse(amountController.text)) {
                                    toast(
                                        'Minimum amount is ${Strings.settings[0].minDepositRate} Rs');
                                    return;
                                  }
                                  if (int.parse(Strings
                                          .settings[0].maxDepositRate
                                          .toString()) <
                                      int.parse(amountController.text)) {
                                    toast(
                                        'Maximum amount is ${Strings.settings[0].maxDepositRate} Rs');
                                    return;
                                  }
                                  var url = await widget.pay(
                                    amount: amountController.text,
                                  );
                                  if (url != "#") {
                                    launchurl(url);
                                  }
                                },
                                child: Text("Auto Pay",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            heightSpace20,
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColorback,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixText: "₹",
                                  hintText: "Enter Points",
                                  hintStyle: TextStyle(
                                      fontSize: 28,
                                      color: Colors.white60,
                                      fontWeight: FontWeight.bold),
                                  prefixStyle: TextStyle(
                                      fontSize: 28,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Center(
                              child: Image.network(
                                "$BASE_URL_qr${Strings.settings[0].paymentScreenImg}",
                                height: 220,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primaryColorback),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      Strings.settings[0].upiPaymentId
                                          .toString(),
                                      style: TextStyle(fontSize: 16)),
                                  TextButton(
                                    onPressed: () async {
                                      await Clipboard.setData(ClipboardData(
                                              text: Strings
                                                  .settings[0].upiPaymentId
                                                  .toString()))
                                          .then((_) {
                                        toast("Copied to your clipboard !");
                                      });
                                    },
                                    child: Text("COPY",
                                        style: TextStyle(
                                            color: AppColors.primaryColorback)),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                  Strings.settings[0].paymentScreenMsg ?? ''),
                            ),
                            heightSpace20,
                            Center(
                              child: !isLoading
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColorback),
                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        // if (refController.text.isEmpty) {
                                        //   toast("Please enter the Ref No.");
                                        //   return;
                                        // }
                                        // if (_selectedImage == null) {
                                        //    toast("Please upload payment proof.");
                                        //   return;
                                        // }
                                        if (int.parse(Strings
                                                .settings[0].minDepositRate
                                                .toString()) >
                                            int.parse(amountController.text)) {
                                          toast(
                                              'Minimum amount is ${Strings.settings[0].minDepositRate} Rs');
                                          return;
                                        }
                                        if (int.parse(Strings
                                                .settings[0].maxDepositRate
                                                .toString()) <
                                            int.parse(amountController.text)) {
                                          toast(
                                              'Maximum amount is ${Strings.settings[0].maxDepositRate} Rs');
                                          return;
                                        }
                                        bool isSuccess = await sendPaymentProof(
                                            apiUrl:
                                                'user/credit_request_generate',
                                            amount: amountController.text,
                                            imageFile: _selectedImage);
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Get.back();
                                      },
                                      child: Text("Submit",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    )
                                  : CircularProgressIndicator(),
                            ),
                          ],
                        ),
                        // Editable Amount Input

                        //   Column(
                        //     children: [
                        // // Tab Bar
                        // // Tab Bar View
                        // SizedBox(
                        //   height: 310,
                        //   child: TabBarView(
                        //     controller: _tabController,
                        //     children: [
                        //     Column(
                        //       children: [

                        //     SizedBox(height: 20),
                        //     Container(
                        //       padding: EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //         border: Border.all(color: AppColors.primaryColorback),
                        //         borderRadius: BorderRadius.circular(5),
                        //       ),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(Strings.settings[0].upiPaymentId.toString(),
                        //               style: TextStyle(fontSize: 16)),
                        //           TextButton(
                        //             onPressed: () async {
                        //               await Clipboard.setData(
                        //                        ClipboardData(text: Strings.settings[0].upiPaymentId.toString()))
                        //                   .then((_) {
                        //                 toast("Copied to your clipboard !");
                        //               });
                        //             },
                        //             child: Text("COPY",
                        //                 style: TextStyle(color: AppColors.primaryColorback)),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(height: 10),
                        //     Text(
                        //       "Transfer the amount you want to recharge to us by UPI ID transfer, NOT MOBILE NUMBER.",
                        //       style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        //     ),
                        //     SizedBox(height: 15),
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //       children: [
                        //         PaymentButton("Paytm",amountController.text),
                        //         PaymentButton("PhonePe",amountController.text),
                        //       ],
                        //     ),
                        //     SizedBox(height: 15,),
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //       children: [
                        //         PaymentButton("G Pay",amountController.text),
                        //         PaymentButton("UPI",amountController.text),
                        //       ],
                        //     ),
                        //     SizedBox(height: 20),
                        //       ],
                        //     )
                        //     ,
                        //     Center(
                        //       child: Image.network(
                        //       "$BASE_URL_qr${Strings.settings[0].paymentScreenImg}",
                        //       width: 300,
                        //     ),
                        //     )
                        //   ]),
                        // )
                        // ]
                        //   ),
                        // Text("Please enter Ref No. to complete the recharge."),
                        // SizedBox(height: 10),
                        // TextField(
                        //   controller: refController,
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     hintText: "Ref No.",
                        //   ),
                        // ),

                        // Upload Proof Section (With Dashed Border)
                        // Text("Upload Payment Proof",
                        //     style: TextStyle(fontWeight: FontWeight.bold)),
                        // SizedBox(height: 10),

                        // GestureDetector(
                        //   onTap: _pickImage,
                        //   child: _selectedImage == null
                        //       ? Container(
                        //           height: 150,
                        //           width: double.infinity,
                        //           decoration: BoxDecoration(
                        //             border: Border.all(
                        //                 color: Colors.grey,
                        //                 style: BorderStyle.solid,
                        //                 width: 2),
                        //             borderRadius: BorderRadius.circular(10),
                        //             color: Colors.grey[200],
                        //             boxShadow: [
                        //               BoxShadow(color: Colors.black12, blurRadius: 5)
                        //             ],
                        //           ),
                        //           child: Center(
                        //             child: Column(
                        //               mainAxisAlignment: MainAxisAlignment.center,
                        //               children: [
                        //                 Icon(Icons.add, size: 40, color: Colors.grey[600]),
                        //                 SizedBox(height: 5),
                        //                 Text("Tap to upload proof",
                        //                     style: TextStyle(color: Colors.grey[600])),
                        //               ],
                        //             ),
                        //           ),
                        //         )
                        //       : ClipRRect(
                        //           borderRadius: BorderRadius.circular(10),
                        //           child: Image.file(
                        //             _selectedImage!,
                        //             height: 150,
                        //             width: double.infinity,
                        //             fit: BoxFit.cover,
                        //           ),
                        //         ),
                        // ),
                        // SizedBox(height: 20),

                        // Submit Button
                      ],
                    ))
              ],
            ),
            // Editable Amount Input

            //   Column(
            //     children: [
            // // Tab Bar
            // // Tab Bar View
            // SizedBox(
            //   height: 310,
            //   child: TabBarView(
            //     controller: _tabController,
            //     children: [
            //     Column(
            //       children: [

            //     SizedBox(height: 20),
            //     Container(
            //       padding: EdgeInsets.all(10),
            //       decoration: BoxDecoration(
            //         border: Border.all(color: AppColors.primaryColorback),
            //         borderRadius: BorderRadius.circular(5),
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(Strings.settings[0].upiPaymentId.toString(),
            //               style: TextStyle(fontSize: 16)),
            //           TextButton(
            //             onPressed: () async {
            //               await Clipboard.setData(
            //                        ClipboardData(text: Strings.settings[0].upiPaymentId.toString()))
            //                   .then((_) {
            //                 toast("Copied to your clipboard !");
            //               });
            //             },
            //             child: Text("COPY",
            //                 style: TextStyle(color: AppColors.primaryColorback)),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 10),
            //     Text(
            //       "Transfer the amount you want to recharge to us by UPI ID transfer, NOT MOBILE NUMBER.",
            //       style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            //     ),
            //     SizedBox(height: 15),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         PaymentButton("Paytm",amountController.text),
            //         PaymentButton("PhonePe",amountController.text),
            //       ],
            //     ),
            //     SizedBox(height: 15,),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         PaymentButton("G Pay",amountController.text),
            //         PaymentButton("UPI",amountController.text),
            //       ],
            //     ),
            //     SizedBox(height: 20),
            //       ],
            //     )
            //     ,
            //     Center(
            //       child: Image.network(
            //       "$BASE_URL_qr${Strings.settings[0].paymentScreenImg}",
            //       width: 300,
            //     ),
            //     )
            //   ]),
            // )
            // ]
            //   ),
            // Text("Please enter Ref No. to complete the recharge."),
            // SizedBox(height: 10),
            // TextField(
            //   controller: refController,
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(),
            //     hintText: "Ref No.",
            //   ),
            // ),

            // Upload Proof Section (With Dashed Border)
            // Text("Upload Payment Proof",
            //     style: TextStyle(fontWeight: FontWeight.bold)),
            // SizedBox(height: 10),

            // GestureDetector(
            //   onTap: _pickImage,
            //   child: _selectedImage == null
            //       ? Container(
            //           height: 150,
            //           width: double.infinity,
            //           decoration: BoxDecoration(
            //             border: Border.all(
            //                 color: Colors.grey,
            //                 style: BorderStyle.solid,
            //                 width: 2),
            //             borderRadius: BorderRadius.circular(10),
            //             color: Colors.grey[200],
            //             boxShadow: [
            //               BoxShadow(color: Colors.black12, blurRadius: 5)
            //             ],
            //           ),
            //           child: Center(
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Icon(Icons.add, size: 40, color: Colors.grey[600]),
            //                 SizedBox(height: 5),
            //                 Text("Tap to upload proof",
            //                     style: TextStyle(color: Colors.grey[600])),
            //               ],
            //             ),
            //           ),
            //         )
            //       : ClipRRect(
            //           borderRadius: BorderRadius.circular(10),
            //           child: Image.file(
            //             _selectedImage!,
            //             height: 150,
            //             width: double.infinity,
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            // ),
            // SizedBox(height: 20),

            // Submit Button
          ],
        ),
      ),
    );
  }
}

// Payment App Buttons
class PaymentButton extends StatelessWidget {
  final String label;
  final String amount;
  PaymentButton(this.label, this.amount);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * .43,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(color: AppColors.primaryColorback))),
        onPressed: () {
          switch (label) {
            case "Paytm":
              launchurl('paytmmp://upi');
              break;
            case "PhonePe":
              launchurl("phonepe://upi");
              break;
            case "G Pay":
              launchurl("gpay://upi");
              break;
            default:
              launchurl(
                  'upi://pay?pa=${Strings.settings[0].upiPaymentId}&pn=${Strings.settings[0].upiName?.replaceAll(' ', '%20')}&cu=INR&am=${amount}');
              ;
              break;
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              label == "Paytm"
                  ? ImagePath.paytm
                  : label == "PhonePe"
                      ? ImagePath.phonepe
                      : label == "G Pay"
                          ? ImagePath.gpay
                          : ImagePath.upi,
              height: 30,
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
