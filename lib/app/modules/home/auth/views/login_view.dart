import 'package:azmatka/app/modules/home/auth/controllers/login_controller.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/share.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());
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
                  height: 150,
                  width: 150,
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
                  heightSpace20,
                  CustomWidgets().buildMaterialBtn(
                      text: 'Login',
                      onPressed: () {
                        // Get.offAll(() => HomeView());
                        controller.loginApi();
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
                  heightSpace10,
                  Divider(
                    color: Colors.white60,
                    thickness: 1,
                  ),
                  heightSpace10,
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                        onTap: () {
                          Get.offAllNamed('/forgot');
                        },
                        child: Text(
                          'Forgot Password ?',
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
