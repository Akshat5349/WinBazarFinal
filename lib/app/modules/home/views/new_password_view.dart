import 'package:azmatka/app/modules/home/controllers/new_password_controller.dart';
import 'package:azmatka/constants/values.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NewPasswordController());
    return Scaffold(
      appBar: AppBar(
        title: Text('New Password'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              heightSpace30,
              Container(
                width: Get.width,
                alignment: Alignment.center,
                child: Image.asset(
                  ImagePath.LOGO,
                  height: 150,
                ),
              ),
              heightSpace30,
              Container(
                width: Get.width,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    heightSpace40,
                    CustomWidgets().buildTextFormField(
                      hintText: 'Current Password',
                      backgroundColor: Colors.white,
                      controller: controller.oldPasswordController,
                      prefixIcon: Icon(Icons.lock),
                      darkMode: false,
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          Icons.remove_red_eye,
                        ),
                      ),
                    ),
                    heightSpace20,
                    CustomWidgets().buildTextFormField(
                      hintText: 'New Password',
                      backgroundColor: Colors.white,
                      controller: controller.newPasswordController,
                      prefixIcon: Icon(Icons.lock),
                      darkMode: false,
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          Icons.remove_red_eye,
                        ),
                      ),
                    ),
                    heightSpace20,
                    CustomWidgets().buildTextFormField(
                      hintText: 'Confirm Password',
                      backgroundColor: Colors.white,
                      prefixIcon: Icon(Icons.lock),
                      controller: controller.confirmPasswordController,
                      darkMode: false,
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          Icons.remove_red_eye,
                        ),
                      ),
                    ),
                    heightSpace40,
                    heightSpace20,
                    CustomWidgets().buildMaterialBtn(
                        text: 'Submit',
                        onPressed: () {
                          controller.changePasswordApi();
                        }),
                    heightSpace40,
                    heightSpace40
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
