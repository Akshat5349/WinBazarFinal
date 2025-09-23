import 'package:azmatka/app/modules/home/auth/controllers/forgot_password_controller.dart';
import 'package:azmatka/constants/values.dart';

import '../../../../../widgets/share.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ForgotPasswordController());
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
              child: Column(
                children: [
                  heightSpace30,
                  CustomWidgets().buildTextFormField(
                    darkMode: false,
                    hintText: 'Mobile Number',
                    keyboardType: TextInputType.number,
                    controller: controller.mobileController,
                    prefixIcon: Icon(
                      Icons.phone_android_outlined,
                      color: Colors.blueAccent,
                    ),
                  ),
                  heightSpace30,
                  CustomWidgets().buildMaterialBtn(
                      text: 'Get OTP',
                      onPressed: () {
                        // Get.offAll(() => HomeView());
                        controller.forgotApi();
                      },
                      color: AppColors.pinkColor),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                        onTap: () {
                          Get.offAllNamed('/signup');
                        },
                        child: Text(
                          'New User? Register',
                          style: BaseStyles.accentMedium18,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
