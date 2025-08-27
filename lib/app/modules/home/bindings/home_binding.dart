import 'package:azmatka/app/modules/home/controllers/result_controller.dart';
import 'package:get/get.dart';

import 'package:azmatka/app/modules/home/controllers/add_bank_controller.dart';
import 'package:azmatka/app/modules/home/controllers/add_paytm_controller.dart';
import 'package:azmatka/app/modules/home/controllers/bid_history_controller.dart';
import 'package:azmatka/app/modules/home/controllers/faq_controller.dart';
import 'package:azmatka/app/modules/home/controllers/game_bet_controller.dart';
import 'package:azmatka/app/modules/home/controllers/games_controller.dart';
import 'package:azmatka/app/modules/home/controllers/instruction_controller.dart';
import 'package:azmatka/app/modules/home/controllers/main_drawer_controller.dart';
import 'package:azmatka/app/modules/home/controllers/new_password_controller.dart';
import 'package:azmatka/app/modules/home/controllers/notice_controller.dart';
import 'package:azmatka/app/modules/home/controllers/product_controller.dart';
import 'package:azmatka/app/modules/home/controllers/product_details_controller.dart';
import 'package:azmatka/app/modules/home/controllers/profile_controller.dart';
import 'package:azmatka/app/modules/home/controllers/select_digit_controller.dart';
import 'package:azmatka/app/modules/home/controllers/splash_controller.dart';
import 'package:azmatka/app/modules/home/controllers/starline_controller.dart';
import 'package:azmatka/app/modules/home/controllers/wallet_controller.dart';
import 'package:azmatka/app/modules/home/controllers/wallet_history_controller.dart';
import 'package:azmatka/app/modules/home/controllers/winning_history_controller.dart';
import 'package:azmatka/app/modules/home/controllers/withdraw_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailsController>(
      () => ProductDetailsController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut<StarlineController>(
      () => StarlineController(),
    );
    Get.lazyPut<WithdrawController>(
      () => WithdrawController(),
    );
    Get.lazyPut<WalletHistoryController>(
      () => WalletHistoryController(),
    );
    Get.lazyPut<WalletController>(
      () => WalletController(),
    );
    Get.lazyPut<MainDrawerController>(
      () => MainDrawerController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<NewPasswordController>(
      () => NewPasswordController(),
    );
    Get.lazyPut<NoticeController>(
      () => NoticeController(),
    );
    Get.lazyPut<InstructionController>(
      () => InstructionController(),
    );
    Get.lazyPut<FaqController>(
      () => FaqController(),
    );
    Get.lazyPut<SelectDigitController>(
      () => SelectDigitController(),
    );

    Get.lazyPut<GamesController>(
      () => GamesController(),
    );
    Get.lazyPut<AddPaytmController>(
      () => AddPaytmController(),
    );
    Get.lazyPut<AddBankController>(
      () => AddBankController(),
    );
    Get.lazyPut<GameBetController>(
      () => GameBetController(),
    );
    Get.lazyPut<WinningHistoryController>(
      () => WinningHistoryController(),
    );
    Get.lazyPut<BidHistoryController>(
      () => BidHistoryController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ResultController>(
      () => ResultController(),
    );
  }
}
