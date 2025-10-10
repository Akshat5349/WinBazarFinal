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
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: Text("Gali Disawar"),
          centerTitle: false,
          actions: [
            controller.approve.value == 'true'
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.goldColor, Color(0xFFFFA000)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      onTap: () {
                        SystemSound.play(SystemSoundType.click);
                        Get.to(() => WalletView());
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            color: AppColors.whiteColor,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Obx(
                            () => Text(
                              "₹${controller.userWallet['wallet_balance'].toString()}",
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Single Digit Card
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 8),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(0.1),
                                        AppColors.primaryColor
                                            .withOpacity(0.05),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryColor
                                            .withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Left side - Icon and label
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor
                                                  .withOpacity(0.15),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.casino,
                                              color: AppColors.primaryColor,
                                              size: 16,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Single Digit',
                                            style: TextStyle(
                                              color: AppColors.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Right side - Rate badge
                                      Text(
                                        '10/90',
                                        style: TextStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Jodi Digit Card
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.successColor.withOpacity(0.1),
                                        AppColors.successColor
                                            .withOpacity(0.05),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: AppColors.successColor
                                          .withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.successColor
                                            .withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Left side - Icon and label
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: AppColors.successColor
                                                  .withOpacity(0.15),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.looks_two,
                                              color: AppColors.successColor,
                                              size: 16,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Jodi Digit',
                                            style: TextStyle(
                                              color: AppColors.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Right side - Rate badge
                                      Text(
                                        '10/900',
                                        style: TextStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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

                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: isMarketClosed
                                                  ? AppColors.errorColor
                                                  : isMarketOpen
                                                      ? AppColors.successColor
                                                      : AppColors.primaryColor,
                                              width: 2,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.blackColor
                                                    .withOpacity(0.1),
                                                blurRadius: 12,
                                                offset: Offset(0, 6),
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

                                                    // Market name and numbers
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            item['market_name']
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .blackColor,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  'Poppins',
                                                              letterSpacing:
                                                                  0.5,
                                                            ),
                                                          ),
                                                          SizedBox(height: 4),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                item['results'] ==
                                                                        null
                                                                    ? "*"
                                                                    : item['results']['open_pana'] ==
                                                                            null
                                                                        ? "*"
                                                                        : item['results']['open_pana'].length ==
                                                                                0
                                                                            ? "*"
                                                                            : item['results']['date'] == today
                                                                                ? item['results']['open_pana']['text_value'][item['results']['open_pana']['text_value'].length - 1]
                                                                                : "*",
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ),
                                                              ),
                                                              Text(
                                                                " • ",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .grey,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              Text(
                                                                item['results'] ==
                                                                        null
                                                                    ? "*"
                                                                    : item['results']['close_pana'] ==
                                                                            null
                                                                        ? "*"
                                                                        : item['results']['close_pana'].length ==
                                                                                0
                                                                            ? "*"
                                                                            : item['results']['date'] == today
                                                                                ? item['results']['close_pana']['text_value'][0]
                                                                                : "*",
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
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
                                                          border: Border.all(
                                                            color: AppColors
                                                                .primaryColor,
                                                            width: 1.5,
                                                          ),
                                                          color: AppColors
                                                              .primaryColor
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Icon(
                                                          Icons.trending_up,
                                                          color: AppColors
                                                              .primaryColor,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 12),
                                                    // Right side play/close icon
                                                    GestureDetector(
                                                      onTap: () {
                                                        SystemSound.play(
                                                            SystemSoundType
                                                                .click);
                                                        if (isMarketOpen ||
                                                            !isMarketClosed) {
                                                          if (controller.approve
                                                                  .value ==
                                                              "true") {
                                                            Get.to(
                                                                () =>
                                                                    GamesView(),
                                                                arguments: {
                                                                  'id': item[
                                                                          '_id']
                                                                      .toString(),
                                                                  'name': item[
                                                                          'market_name']
                                                                      .toString(),
                                                                  'type':
                                                                      'Jodi',
                                                                  'market_type':
                                                                      item['market_type']
                                                                          .toString(),
                                                                  "item": item,
                                                                  "open": true,
                                                                  "close": true
                                                                });
                                                          } else {
                                                            Get.toNamed(
                                                                '/quiz');
                                                          }
                                                        } else {
                                                          toast(
                                                              'Market is closed');
                                                        }
                                                      },
                                                      child: Container(
                                                        width: 36,
                                                        height: 36,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: (isMarketClosed
                                                                  ? AppColors
                                                                      .errorColor
                                                                  : isMarketOpen
                                                                      ? AppColors
                                                                          .successColor
                                                                      : AppColors
                                                                          .primaryColor)
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color:
                                                                isMarketClosed
                                                                    ? AppColors
                                                                        .errorColor
                                                                    : isMarketOpen
                                                                        ? AppColors
                                                                            .successColor
                                                                        : AppColors
                                                                            .primaryColor,
                                                            width: 1.5,
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          isMarketClosed
                                                              ? Icons.close
                                                              : Icons
                                                                  .play_arrow,
                                                          color: isMarketClosed
                                                              ? AppColors
                                                                  .errorColor
                                                              : isMarketOpen
                                                                  ? AppColors
                                                                      .successColor
                                                                  : AppColors
                                                                      .primaryColor,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                // Bottom row with times and status
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 12),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
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
                                                              color: AppColors
                                                                  .blackColor,
                                                              fontSize: 11,
                                                            ),
                                                          ),
                                                          Text(
                                                            openDate.toString(),
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .blackColor,
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
                                                                horizontal: 24,
                                                                vertical: 2),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color(
                                                              0xFFd4af37), // Gold background
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
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
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
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
        bottomNavigationBar: controller.approve.value == 'true'
            ? Container(
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
                        icon: Icon(Icons.account_balance_wallet_outlined,
                            size: 24),
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
              )
            : null,
        floatingActionButton: controller.approve.value == 'true'
            ? Container(
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
              )
            : null,
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
