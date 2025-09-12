import 'package:audioplayers/audioplayers.dart';
import 'package:azmatka/app/modules/home/views/games_view.dart';
import 'package:azmatka/app/modules/home/views/home_view.dart';
import 'package:azmatka/app/modules/home/views/jodi_bid_history_view.dart';
import 'package:azmatka/app/modules/home/views/jodi_winning_history_view.dart';
import 'package:azmatka/app/modules/home/views/payment_screen.dart';
import 'package:azmatka/app/modules/home/views/wallet_view.dart';
import 'package:azmatka/app/modules/home/views/withdraw_view.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/base_url.dart';
import 'package:azmatka/widgets/main_drawer.dart';
import 'package:azmatka/widgets/share.dart';
import 'package:azmatka/widgets/custom_widgets.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/gali_disawar_controller.dart';

class GaliDisawarView extends GetView<GaliDisawarController> {
  final player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    // Play bell sound when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playBellSound();
    });

    initializeDateFormatting('es');
    var now = DateTime.now();
    var today = DateFormat.yMd('es').format(now);
    Get.lazyPut(() => GaliDisawarController());
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          title: Text("Gali Disawar"),
          centerTitle: false,
          actions: [
            controller.approve.value == 'true'
                ? InkWell(
                    onTap: () {
                      Get.to(() => WalletView());
                    },
                    child: Icon(Icons.account_balance_wallet_outlined),
                  )
                : Container(),
            widthSpace5,
            controller.approve.value == 'true'
                ? Obx(
                    () => Align(
                        alignment: Alignment.center,
                        child: Text(
                          controller.userWallet['wallet_balance'].toString(),
                          style:
                              BaseStyles.whiteMedium18.copyWith(fontSize: 20),
                        )),
                  )
                : Container(),
            widthSpace10,
          ],
        ),
        body: controller.homeLoading.value
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  controller.homeApi();
                  controller.resultHistory();
                  controller.wallet();
                },
                child: Column(
                  children: [
                    Container(
                      child: Column(children: [
                        heightSpace20,
                        // Row(
                        //   children: [
                        //     widthSpace10,
                        //     Image.asset(
                        //       ImagePath.LOGO,
                        //       height: 100,
                        //       width: 100,
                        //     ),
                        //     Expanded(
                        //       child: Column(
                        //         children: [
                        //           Text(
                        //             'Welcome To ${controller.appname} Game',
                        //             style: BaseStyles.blackNormal18
                        //                 .copyWith(fontWeight: FontWeight.w700),
                        //           ),
                        //           heightSpace20,
                        //           Text(
                        //             'Let’s Start Playing Now',
                        //             style: BaseStyles.blackNormal18,
                        //           )
                        //         ],
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // heightSpace20,
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                width: Get.width * 0.45,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFFd4af37), width: 1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Single Digit : 10/90',
                                      style: BaseStyles.goldMedium14,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                width: Get.width * 0.45,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFFd4af37), width: 1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 6),
                                    Text(
                                      "Jodi Digit : 10/900",
                                      style: BaseStyles.goldMedium14,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        heightSpace20,
                      ]),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     launchurl(
                    //         'https://onlineplaygame.in/assets/app/dhanlaxmi.apk');
                    //   },
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     width: Get.width * 0.98,
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(50),
                    //         gradient: LinearGradient(colors: [
                    //           AppColors.pinkColor,
                    //           AppColors.blueColor,
                    //         ])),
                    //     child: Row(
                    //       children: [
                    //         widthSpace10,
                    //         Icon(
                    //           Icons.download,
                    //           color: Colors.white,
                    //           size: 35,
                    //         ),
                    //         Spacer(),
                    //         Text(
                    //           'Download APK',
                    //           style: BaseStyles.whiteMedium18,
                    //         ),
                    //         Spacer(),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // heightSpace40,
                    Obx(
                      () => controller.loading.value
                          ? CircularProgressIndicator()
                          : controller.market.length == 0
                              ? Text('No Market Available')
                              : Expanded(
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.market.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var item = controller.market[index];
                                        var date = DateTime.now();
                                        String? d;
                                        String? m;
                                        if (date.day <= 9) {
                                          d = "0${date.day}";
                                        } else {
                                          d = "${date.day}";
                                        }
                                        if (date.month <= 9) {
                                          m = "0${date.month}";
                                        } else {
                                          m = "${date.month}";
                                        }
                                        var openDate = DateFormat.jm().format(
                                            DateTime.parse(
                                                "${date.year}-${m}-${d} ${item['open_time']}:00.000000"));
                                        DateTime opendateClose = DateTime.parse(
                                            "${date.year}-${m}-${d} ${item['open_time']}:00.000000");
                                        var closeDate = DateFormat.jm().format(
                                            DateTime.parse(
                                                "${date.year}-${m}-${d} ${item['close_time']}:00.000000"));
                                        DateTime closeDateCompair = DateTime.parse(
                                            "${date.year}-${m}-${d} ${item['close_time']}:00.000000");
                                        // Check if market is open based on current time
                                        bool isMarketOpen = date.compareTo(
                                                    closeDateCompair) <
                                                0 &&
                                            date.compareTo(opendateClose) > 0;
                                        bool isMarketClosed =
                                            date.compareTo(closeDateCompair) >=
                                                0;

                                        return GestureDetector(
                                          onTap: () {
                                            if (isMarketOpen ||
                                                !isMarketClosed) {
                                              if (controller.approve.value ==
                                                  "true") {
                                                Get.to(() => GamesView(),
                                                    arguments: {
                                                      'id': item['_id']
                                                          .toString(),
                                                      'name':
                                                          item['market_name']
                                                              .toString(),
                                                      'type': 'Jodi',
                                                      'market_type':
                                                          item['market_type']
                                                              .toString(),
                                                      "item": item,
                                                      "open": true,
                                                      "close": true
                                                    });
                                              } else {
                                                Get.toNamed('/quiz');
                                              }
                                            } else {
                                              toast('Market is closed');
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 6),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(
                                                      0xFF1a2332), // Dark navy blue
                                                  Color(
                                                      0xFF2a3441), // Slightly lighter navy
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Color(0xFFd4af37),
                                                width: 1,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  blurRadius: 8,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 4),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Top row with market name and play/close icon
                                                  Row(
                                                    children: [
                                                      // Left side arrow icon
                                                      GestureDetector(
                                                        onTap: () {
                                                          SystemSound.play(
                                                              SystemSoundType
                                                                  .click);
                                                          Get.toNamed(
                                                            '/chart?market_name=${item['market_name']}&market_slug=${item['market_slug']}',
                                                          );
                                                        },
                                                        child: Container(
                                                          width: 32,
                                                          height: 32,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                    0xFFd4af37)
                                                                .withOpacity(
                                                                    0.2), // Gold background
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Icon(
                                                            Icons.trending_up,
                                                            color: Color(
                                                                0xFFd4af37), // Gold color
                                                            size: 18,
                                                          ),
                                                        ),
                                                      ),
                                                      // Market name and numbers
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              item['market_name']
                                                                  .toString()
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFFd4af37), // Gold color
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    0.5,
                                                              ),
                                                            ),
                                                            SizedBox(height: 4),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  item['results'] ==
                                                                          null
                                                                      ? "*"
                                                                      : item['results']['open_pana'] ==
                                                                              null
                                                                          ? "*"
                                                                          : item['results']['open_pana'].length == 0
                                                                              ? "*"
                                                                              : item['results']['date'] == today
                                                                                  ? item['results']['open_pana']['text_value'][item['results']['open_pana']['text_value'].length - 1]
                                                                                  : "*",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  item['results'] ==
                                                                          null
                                                                      ? "*"
                                                                      : item['results']['close_pana'] ==
                                                                              null
                                                                          ? "*"
                                                                          : item['results']['close_pana'].length == 0
                                                                              ? "*"
                                                                              : item['results']['date'] == today
                                                                                  ? item['results']['close_pana']['text_value'][0]
                                                                                  : "*",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // Right side play/close icon
                                                      Container(
                                                        width: 36,
                                                        height: 36,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color(
                                                                  0xFFd4af37)
                                                              .withOpacity(0.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFd4af37),
                                                            width: 1.5,
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          isMarketClosed
                                                              ? Icons.close
                                                              : Icons
                                                                  .play_arrow,
                                                          color:
                                                              Color(0xFFd4af37),
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  // Bottom row with times and status
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 12),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 6),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFd4af37)
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      spacing: 20,
                                                      children: [
                                                        // Open time
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              "Open",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white60,
                                                                fontSize: 11,
                                                              ),
                                                            ),
                                                            Text(
                                                              openDate
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        // Center status button
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      30,
                                                                  vertical: 2),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFd4af37), // Gold background
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          child: Text(
                                                            isMarketClosed
                                                                ? 'Close for today'
                                                                : 'Market Running',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF1a2332), // Dark navy text
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                    )
                  ],
                ),
              ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: AppColors.pinkColor,
              unselectedItemColor: Colors.grey[600],
              selectedFontSize: 12,
              unselectedFontSize: 10,
              currentIndex: 0, // Default to home/My Bids
              onTap: (index) {
                switch (index) {
                  case 0:
                    // My Bids - stay on current page or navigate to bids page
                    Get.to(() => JodiBidHistoryView(), arguments: {
                      'type': 'regular',
                    });
                    break;
                  case 1:
                    // Passbook - navigate to wallet history or transaction history
                    Get.to(() => JodiWinningHistoryView(), arguments: {
                      'type': 'regular',
                    });
                    break;
                  case 2:
                    // Home/Center button - handled by floating action button
                    Get.to(() => HomeView());
                    break;
                  case 3:
                    // Funds - navigate to wallet/payment screen
                    if (controller.approve.value == 'true') {
                      Get.to(() => WalletView());
                    }
                    break;
                  case 4:
                    // Support - navigate to support/contact page
                    break;
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt, size: 24),
                  label: 'My Bids',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_outlined, size: 24),
                  label: 'Winnings',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox.shrink(), // Empty for center FAB
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance, size: 24),
                  label: 'Funds',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.support_agent, size: 24),
                  label: 'Support',
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.pinkColor, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.pinkColor.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: FloatingActionButton(
              onPressed: () {
                // Navigate to home or main action
                Get.back();
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Image.asset(ImagePath.LOGO)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    });
  }

  // Method to play bell sound when screen loads
  void _playBellSound() async {
    try {
      // Use the enhanced bell sound from AudioService
      await player.play(AssetSource('audio/click.mp3'));
    } catch (e) {
      print('AudioService failed: $e');

      try {
        // Fallback: Create bell effect manually
        SystemSound.play(SystemSoundType.alert);
        HapticFeedback.heavyImpact();

        // Create echo effect
        Future.delayed(Duration(milliseconds: 150), () {
          SystemSound.play(SystemSoundType.click);
          HapticFeedback.mediumImpact();
        });

        Future.delayed(Duration(milliseconds: 300), () {
          HapticFeedback.lightImpact();
        });
      } catch (e2) {
        print('SystemSound failed: $e2');

        try {
          // Last resort: Just haptic feedback
          HapticFeedback.heavyImpact();
          Future.delayed(Duration(milliseconds: 100), () {
            HapticFeedback.mediumImpact();
          });
          Future.delayed(Duration(milliseconds: 200), () {
            HapticFeedback.lightImpact();
          });
        } catch (e3) {
          print('All sound methods failed: $e3');
        }
      }
    }
  }

  // Widget setupAlertDialoadContainer() {
  //   return Obx(() => Container(
  //         //height: 300.0, // Change as per your requirement
  //         width: 300.0, // Change as per your requirement
  //         child: ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: controller.newResult.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             final item = controller.newResult[index];
  //             return ListTile(
  //               title: Text(item['market_id']['market_name']),
  //               subtitle: Text(item['date']),
  //               trailing: Text(item['result_number'].toString()),
  //               leading: Text("${index + 1}"),
  //             );
  //           },
  //         ),
  //       ));
  // }
}
