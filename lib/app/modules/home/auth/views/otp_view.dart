import 'package:azmatka/constants/values.dart';

import '../../../../../widgets/share.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OtpController());
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
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
                      hintText: 'Otp',
                      keyboardType: TextInputType.number,
                      controller: controller.otpController,
                      prefixIcon: Icon(
                        Icons.phone_android_outlined,
                        color: Colors.blueAccent,
                      ),
                    ),
                    heightSpace20,
                    Obx(
                      () => CustomWidgets().buildTextFormField(
                          darkMode: false,
                          hintText: 'New Password',
                          obscureText: !controller.showPass.value,
                          validator: (value) =>
                              FieldValidator(context).passwordValidate(value),
                          controller: controller.passwordController,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.blueAccent,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              controller.showPass.value =
                                  !controller.showPass.value;
                            },
                            child: Icon(
                              controller.showPass.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.blueAccent,
                            ),
                          )),
                    ),
                    heightSpace40,
                    CustomWidgets().buildMaterialBtn(
                        text: 'VERIFY OTP',
                        onPressed: () {
                          // Get.offAll(() => HomeView());
                          controller.verifyOtp();
                        },
                        color: AppColors.pinkColor),
                    // heightSpace30,
                    // CustomWidgets().buildMaterialBtn(
                    //     text: 'SIGN UP?',
                    //     onPressed: () {
                    //       Get.off(() => SignupView());
                    //     },
                    //     color: AppColors.primaryColor),
                    // heightSpace10,
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: Text(
                    //     'Forgot Password ?',
                    //     style: BaseStyles.purpleMedium16,
                    //   ),
                    // ),
                    heightSpace30,
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
