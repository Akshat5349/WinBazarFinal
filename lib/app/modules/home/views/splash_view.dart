import 'package:azmatka/app/modules/home/controllers/splash_controller.dart';
import 'package:azmatka/constants/values.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SplashController());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: controller.animation1,
          builder: (BuildContext context, Widget? child) {
            return CircleAvatar(
              radius: controller.animation1.value,
              backgroundImage: AssetImage(
                ImagePath.LOGO,
              ),
            );
          },
        ),
      ),
    );
  }
}
