// ignore_for_file: unnecessary_null_comparison

import 'package:azmatka/app/modules/home/controllers/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:azmatka/constants/values.dart';

// Bid model to store individual bet details
class BidModel {
  final String amount;
  final String number;
  final String openPana;
  final String closePana;
  final String openDigit;
  final String closeDigit;
  final String gameTypeId;
  final String gameId;
  final String session;
  final String gameTitle;
  final String marketName;

  BidModel({
    required this.amount,
    required this.number,
    required this.openPana,
    required this.closePana,
    required this.openDigit,
    required this.closeDigit,
    required this.gameTypeId,
    required this.gameId,
    required this.session,
    required this.gameTitle,
    required this.marketName,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'number': number,
      'open_pana': openPana,
      'close_pana': closePana,
      'open_digit': openDigit,
      'close_digit': closeDigit,
      'game_type_id': gameTypeId,
      'market_id': gameId,
      'session': session,
    };
  }
}

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

  // Observable list to store all bids before submission
  final bidList = <BidModel>[].obs;
  final isSubmittingBids = false.obs;

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

  // Add bid to the list instead of submitting immediately
  addBidToCart() {
    if (open == false && close == true) {
      selectvalue.value = 2;
    }

    // Validation logic
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

    // Create new bid and add to list
    final newBid = BidModel(
      amount: pointContoller.text,
      number: digitContoller.text,
      openPana: openPanaContoller.text,
      closePana: closePanaContoller.text,
      openDigit: openDigitContoller.text,
      closeDigit: closeDigitContoller.text,
      gameTypeId: gameTypeId,
      gameId: gameId,
      session: selectvalue == 1 ? 'open' : 'close',
      gameTitle: title,
      marketName: appTitle,
    );

    bidList.add(newBid);

    // Clear form fields for next bid
    clearForm();

    toast('Bid added to cart (${bidList.length} bids)');
  }

  // Clear form fields
  clearForm() {
    digitContoller.clear();
    openPanaContoller.clear();
    closePanaContoller.clear();
    openDigitContoller.clear();
    closeDigitContoller.clear();
    pointContoller.clear();
  }

  // Remove a specific bid from the list
  removeBid(int index) {
    if (index >= 0 && index < bidList.length) {
      bidList.removeAt(index);
      toast('Bid removed from cart');
    }
  }

  // Clear all bids from the list
  clearAllBids() {
    bidList.clear();
    toast('All bids cleared');
  }

  // Get total amount of all bids
  double getTotalAmount() {
    return bidList.fold(0.0, (sum, bid) => sum + double.parse(bid.amount));
  }

  // Submit all bids at once
  submitAllBids() async {
    if (bidList.isEmpty) {
      toast('No bids to submit. Add some bids first.');
      return;
    }

    isSubmittingBids.value = true;

    try {
      List<Map<String, dynamic>> successfulBids = [];
      List<String> failedBids = [];

      // Submit each bid
      for (int i = 0; i < bidList.length; i++) {
        final bid = bidList[i];

        try {
          var res = await ApiProvider().postRequest(
            temp: true,
            apiUrl: 'user/bid_create',
            data: bid.toJson(),
            token: 'Bearer ${box.read('token')}',
          );

          if (res['success'].toString() == 'true') {
            successfulBids.add(bid.toJson());
          } else {
            failedBids
                .add('${bid.gameTitle} - ${bid.number} (${res['message']})');
          }
        } catch (e) {
          failedBids.add('${bid.gameTitle} - ${bid.number} (Network Error)');
        }
      }

      // Show results
      if (successfulBids.length == bidList.length) {
        toast('All ${bidList.length} bids placed successfully!');
        bidList.clear();
        home.wallet();
      } else if (successfulBids.isNotEmpty) {
        toast(
            '${successfulBids.length}/${bidList.length} bids placed successfully');

        // Remove successful bids from the list
        bidList.removeWhere((bid) {
          return successfulBids.any((successful) =>
              successful['number'] == bid.number &&
              successful['amount'] == bid.amount);
        });

        home.wallet();
      } else {
        toast('All bids failed. Please check your connection and try again.');
      }

      if (failedBids.isNotEmpty) {
        print('Failed bids: ${failedBids.join(', ')}');
      }
    } catch (e) {
      print('Batch submission error: ${e.toString()}');
      toast('Failed to submit bids. Please try again.');
    } finally {
      isSubmittingBids.value = false;
    }
  }

  // Legacy method for compatibility (now calls addBidToCart)
  submitApi() {
    addBidToCart();
  }
}
