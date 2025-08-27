import 'package:azmatka/constants/values.dart';

class AddBankController extends GetxController {
  TextEditingController accountNoController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController accountHolderController = TextEditingController();
  final bankDetails = {}.obs;
  final userData = {}.obs;

  @override
  void onInit() {
    super.onInit();
    // getBankApi();
    profileApi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  addBankApi() async {
    if (accountNoController.text.isEmpty) {
      toast('Please Enter Account Number');
    } else if (bankNameController.text.isEmpty) {
      toast('Please Enter Bank Name');
    } else if (ifscCodeController.text.isEmpty) {
      toast('Please Enter IFSC Code');
    } else if (accountHolderController.text.isEmpty) {
      toast('Please Enter Account Holder Name');
    } else {
      var d = {
        'account_number': accountNoController.text,
        'bank_name': bankNameController.text,
        'ifsc_code': ifscCodeController.text,
        'account_holder_name': accountHolderController.text,
        'token': box.read('token'),
        'type': 'bank'
      };

      try {
        var res = await ApiProvider().postRequest2(
            apiUrl: 'user/profile-update',
            data: d,
            token: 'Bearer ${box.read('token')}');

        Get.back();
      } catch (e) {
        toast(e.toString());
        print(e.toString());
      }
    }
  }

  profileApi() async {
    try {
      var res = await ApiProvider().postRequest(
          apiUrl: 'user/get_user_profile',
          token: '${box.read('token')}',
          data: {'token': box.read('token')});
      userData.addAll(res);
      accountNoController.text = res['account_number'] ?? "";
      bankNameController.text = res['bank_name'] ?? "";
      ifscCodeController.text = res['ifsc_code'] ?? "";
      accountHolderController.text = res['account_holder_name'] ?? "";
    } catch (e) {
      print(e.toString());
    }
  }
}
