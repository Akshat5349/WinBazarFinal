import 'package:azmatka/app/modules/home/auth/views/forgot_password_view.dart';
import 'package:azmatka/app/modules/home/auth/views/otp_view.dart';
import 'package:azmatka/app/modules/home/views/chart-view.dart';
import 'package:azmatka/app/modules/home/views/faq_view.dart';
import 'package:azmatka/app/modules/home/views/quiz_view.dart';
import 'package:get/get.dart';
import 'package:azmatka/app/modules/home/auth/views/login_view.dart';
import 'package:azmatka/app/modules/home/auth/views/signup_view.dart';
import 'package:azmatka/app/modules/home/views/product_view.dart';
import 'package:azmatka/app/modules/home/views/splash_view.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
    ),
    GetPage(name: _Paths.FORGOTPASSWORD, page: () => ForgotPasswordView()),
    GetPage(name: _Paths.OTP, page: () => OtpView()),
    GetPage(
      name: _Paths.CHART,
      page: () => ChartView(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => ProductView(),
    ),
    GetPage(name: _Paths.FAQ, page: () => FAQScreen()),
    GetPage(name: '/quiz', page: () => QuizScreen()),
  ];
}
