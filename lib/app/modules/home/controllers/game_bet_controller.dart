// ignore_for_file: unnecessary_null_comparison

import 'package:azmatka/app/modules/home/controllers/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:azmatka/constants/values.dart';

// ignore: unnecessary_null_comparison
class GameBetController extends GetxController {
  final home = Get.put(HomeController());
  TextEditingController dateContoller = TextEditingController();
  TextEditingController digitContoller = TextEditingController();
  TextEditingController openPanaContoller = TextEditingController();
  TextEditingController closePanaContoller = TextEditingController();
  TextEditingController openDigitContoller = TextEditingController();
  TextEditingController closeDigitContoller = TextEditingController();
  TextEditingController pointContoller = TextEditingController();
  final selectvalue = 0.obs;

  var gameId = Get.arguments['gameId'];
  var gameTypeId = Get.arguments['gameTypeId'];
  var id = Get.arguments['id'];
  var title = Get.arguments['title'];
  var appTitle = Get.arguments['appTitle'];
  DateTime now = DateTime.now();
  var type = Get.arguments['type'];
  var marketType = Get.arguments['market_type'];
  var item = Get.arguments['item'];
  var open = Get.arguments['open'];
  var close = Get.arguments['close'];

  @override
  void onInit() {
    super.onInit();
    print("Market Type: $marketType");
    if (open == false && close == true) {
      selectvalue.value = 2;
    } else {
      selectvalue.value = 1;
    }

    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    dateContoller.text = formattedDate;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  submitApi() async {
    if (open == false && close == true) {
      selectvalue.value = 2;
    }

    if (digitContoller.text.isEmpty &&
        !(title == 'Half Sangam' || title == 'Full Sangam')) {
      toast('Please Select Digit');
      return;
    } else if (pointContoller.text.length <
        Strings.settings[0].minimumBidAmount!.length) {
      toast('Minimum Bid points is ${Strings.settings[0].minimumBidAmount} Rs');
      return;
    } else if (pointContoller.text.length >=
        Strings.settings[0].maximumBidAmount!.length) {
      toast('Maximum Bid points is ${Strings.settings[0].maximumBidAmount} Rs');
      return;
    }
    if (title == 'Half Sangam') {
      if (selectvalue == 1) {
        if (openPanaContoller.text.isEmpty) {
          toast("Please Select Open Pana");
          return;
        }
        if (closeDigitContoller.text.isEmpty) {
          toast("Please Select Close Digit");
          return;
        }
      } else {
        if (closePanaContoller.text.isEmpty) {
          toast("Please Select Close Pana");
          return;
        }
        if (openDigitContoller.text.isEmpty) {
          toast("Please Select Open Digit");
          return;
        }
      }
    }
    if (title == 'Full Sangam') {
      if (closePanaContoller.text.isEmpty) {
        toast("Please Select Close Pana");
        return;
      }
      if (openPanaContoller.text.isEmpty) {
        toast("Please Select Open Pana");
        return;
      }
    }
    var d = {
      'amount': pointContoller.text,
      'number': digitContoller.text,
      'open_pana': openPanaContoller.text,
      'close_pana': closePanaContoller.text,
      'open_digit': openDigitContoller.text,
      'close_digit': closeDigitContoller.text,
      'game_type_id': gameTypeId,
      'market_id': gameId,
      'session': selectvalue == 1 ? 'open' : 'close',
    };

    // marketType == 'Delhi'
    //     ? d['delhi_market_id'] = gameId
    //     : marketType == 'Mumbai'
    //         ? d['mumbai_market_id'] = gameId
    //         : d['starline_market_id'] = gameId;

    //  appTitle == ''
    try {
      var res = await ApiProvider().postRequest(
          temp: true,
          apiUrl: 'user/bid_create',
          data: d,
          token: 'Bearer ${box.read('token')}');

      if (res['success'].toString() == 'true') {
        toast('Bet Placed Successfully');

        digitContoller.clear();
        pointContoller.clear();
        home.wallet();
        //Get.offAll(() => HomeView());
      } else {
        toast('${res['message']}');
      }
    } catch (e) {
      digitContoller.clear();
      pointContoller.clear();
      print(e.toString());
      toast('Bet Failed');
    }
  }
}
