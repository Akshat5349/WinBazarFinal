import 'dart:io';

import 'package:azmatka/app/modules/home/controllers/profile_controller.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/base_url.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              heightSpace40,
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 140,
                  height: 140,
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Obx(
                        () => Positioned(
                            top: 0,
                            child: controller.isPick.value == true
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(
                                      File(controller.imagePath.value),
                                    ),
                                  )
                                : controller.networkImage != ''
                                    ? CircleAvatar(
                                        radius: 60,
                                        backgroundImage: NetworkImage(
                                          '${BASE_URL_image2}/${controller.networkImage.value}',
                                        ),
                                      )
                                    : Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/Ellipse2.png'),
                                              fit: BoxFit.fitWidth),
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(120, 120)),
                                        ))),
                      ),
                      Positioned(
                          bottom: 20,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              controller.imagePick();
                            },
                            child: Container(
                                width: 39,
                                height: 39,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/Download41.png'),
                                      fit: BoxFit.fitWidth),
                                )),
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    CustomWidgets().buildTextFormField(
                      darkMode: true,
                      controller: controller.nameController,
                      prefixIcon: Icon(Icons.person),
                    ),
                    heightSpace30,
                    CustomWidgets().buildTextFormField(
                      darkMode: true,
                      readOnly: true,
                      controller: controller.mobileController,
                      prefixIcon: Icon(Icons.phone),
                    ),
                    heightSpace30,
                    CustomWidgets().buildTextFormField(
                      darkMode: true,
                      controller: controller.emailController,
                      prefixIcon: Icon(Icons.email),
                    ),
                    heightSpace40,
                    heightSpace40,
                    CustomWidgets().buildMaterialBtn(
                        text: 'Save',
                        onPressed: () {
                          controller.updateProfile();
                        },
                        color: AppColors.pinkColor,
                        radius: 10)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
