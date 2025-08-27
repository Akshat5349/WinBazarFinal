import 'dart:io';

import 'package:azmatka/app/modules/home/providers/get_api_provider.dart';
import 'package:azmatka/app/modules/home/views/home_view.dart';
import 'package:azmatka/constants/values.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final userData = {}.obs;
  final ImagePicker picker = ImagePicker();
  final networkImage = ''.obs;
  XFile? image;
  File? img;
  final imagePath = ''.obs;
  final isPick = false.obs;
  @override
  void onInit() {
    super.onInit();
    profileApi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  imagePick() async {
    image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      isPick.value = true;
      img = File(image!.path);
      imagePath.value = image!.path;
    }
  }

  var box = GetStorage();

  profileApi() async {
    try {
      var res = await ApiProvider().postRequest(
          temp: true,
          apiUrl: 'user/get_user_profile',
          token: '${box.read('token')}',
          data: {'token': box.read('token')});
      userData.addAll(res);
      if (res.containsKey('image')) {
        networkImage.value = res['image'];
      }

      nameController.text = res['name'].toString();
      emailController.text = res['email'].toString();
      mobileController.text = res['mobile_number'].toString();
    } catch (e) {
      print(e.toString());
    }
  }

  updateProfile() async {
    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      toast('Please enter all fields');
    } else {
      var data;
      if (img == null) {
        data = {
          'name': nameController.text,
          'email': emailController.text,
          'token': box.read('token'),
        };
      } else {
        data = FormData({
          'name': nameController.text,
          'email': emailController.text,
          'token': box.read('token'),
          'image': MultipartFile(img!.path,
              filename: '${img!.path.split('/').last}.jpeg')
        });
      }
      try {
        var res = GetApiProvider().postRequest(
            apiUrl: 'user/profile-update',
            data: data,
            token: 'Bearer ${box.read('token')}');
        Get.offAll(() => HomeView());
      } catch (e) {
        print(e.toString());
        toast(e.toString());
      }
    }
  }
}
