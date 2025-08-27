import 'package:azmatka/app/modules/home/auth/controllers/signup_controller.dart';
import 'package:azmatka/constants/values.dart';

import '../../../../../widgets/share.dart';

class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SignupController());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                child: Image.asset(
                  ImagePath.LOGO,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            heightSpace30,
            TextButton(
              onPressed: () {
                launchWhatsapp('+91${Strings.settings[0].whatsapp.toString()}');
              },
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImagePath.whatsapp,
                      height: 30,
                    ),
                    widthSpace10,
                    Text(
                      Strings.settings[0].whatsapp.toString() == ''
                          ? ""
                          : "+91 ${Strings.settings[0].whatsapp.toString()}",
                      style: BaseStyles.whiteMedium16,
                    )
                  ]),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Form(
                key: controller.key,
                child: Column(
                  children: [
                    heightSpace30,
                    CustomWidgets().buildTextFormField(
                      darkMode: false,
                      hintText: 'Name',
                      validator: (value) =>
                          FieldValidator(context).nameValidate(value),
                      controller: controller.nameController,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.blueAccent,
                      ),
                    ),
                    // heightSpace20,
                    // CustomWidgets().buildTextFormField(
                    //   darkMode: false,
                    //   controller: controller.emailController,
                    //   hintText: 'Email',
                    //   validator: (value) =>
                    //       FieldValidator(context).emailValidate(value),
                    //   prefixIcon: Icon(
                    //     Icons.mail_outline_outlined,
                    //     color: AppColors.whiteColor,
                    //   ),
                    // ),
                    heightSpace20,
                    CustomWidgets().buildTextFormField(
                      darkMode: false,
                      hintText: 'Mobile Number',
                      validator: (value) =>
                          FieldValidator(context).mobileValidate(value),
                      keyboardType: TextInputType.number,
                      controller: controller.mobileController,
                      prefixIcon: Icon(
                        Icons.phone_android_outlined,
                        color: Colors.blueAccent,
                      ),
                    ),
                    heightSpace20,
                    Obx(
                      () => CustomWidgets().buildTextFormField(
                          darkMode: false,
                          hintText: 'Password',
                          obscureText: !controller.showPass.value,
                          validator: (value) =>
                              FieldValidator(context).passwordValidate(value),
                          controller: controller.passwordController,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.blueAccent,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: controller.changePass,
                            child: Icon(
                              controller.showPass.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.blueAccent,
                            ),
                          )),
                    ),
                    heightSpace30,
                    CustomWidgets().buildMaterialBtn(
                        text: 'SIGN UP',
                        onPressed: () {
                          controller.signupApi();
                        },
                        color: AppColors.pinkColor),
                    heightSpace20,
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                          onTap: () {
                            Get.offAllNamed('/login');
                          },
                          child: Text(
                            'Already have an account? Login',
                            style: BaseStyles.accentMedium18,
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
