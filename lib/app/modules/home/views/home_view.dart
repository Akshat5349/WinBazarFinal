import 'package:azmatka/app/modules/home/views/games_view.dart';
import 'package:azmatka/app/modules/home/views/payment_screen.dart';
import 'package:azmatka/app/modules/home/views/wallet_view.dart';
import 'package:azmatka/app/modules/home/views/withdraw_view.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/base_url.dart';
import 'package:azmatka/widgets/main_drawer.dart';
import 'package:azmatka/widgets/share.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es');
    var now = DateTime.now();
    var today = DateFormat.yMd('es').format(now);
    Get.lazyPut(() => HomeController());
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          title: Text("WinBazar"),
          centerTitle: false,
          actions: [
            controller.approve.value == 'true'
                ? InkWell(
                    onTap: () {
                      Get.to(() => WalletView());
                    },
                    child: Image.asset(
                      DrawerImages.pointManagement,
                      height: 30,
                      width: 30,
                    ),
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
        drawer: MainDrawer(
          approved: controller.approve.value,
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
                    Obx(
                      () => controller.Sliders.length > 0
                          ? Image.network(
                              '${BASE_URL_slider}${controller.Sliders[0].basename}')
                          : Container(),
                    ),
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
                              InkWell(
                                onTap: () {
                                  launchWhatsapp(
                                      '+91${Strings.settings[0].whatsapp.toString()}');
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  width: Get.width * 0.45,
                                  // alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.goldGradient,
                                    // gradient: LinearGradient(colors: [Colors.red,Colors.black,Colors.red],begin: Alignment.topCenter,end: Alignment.bottomCenter),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Chat',
                                        style: BaseStyles.purpleMedium16,
                                      ),
                                      Icon(
                                        Icons.language,
                                        color: AppColors.pinkColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  launchurl(
                                      'tel:${Strings.settings[0].mobile.toString()}');
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  width: Get.width * 0.45,
                                  // alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.goldGradient,
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Gali Disawar',
                                        style: BaseStyles.purpleMedium16,
                                      ),
                                      Icon(
                                        Icons.play_arrow_outlined,
                                        color: AppColors.pinkColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        controller.approve.value == 'true'
                            ? Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (controller.approve.value ==
                                            'true') {
                                          Get.to(PaymentScreen());
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        width: Get.width * 0.45,
                                        // alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          gradient: AppColors.goldGradient,
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              controller.loading.value
                                                  ? ""
                                                  : Strings.settings[0]
                                                      .paymentBtnText
                                                      .toString(),
                                              style: BaseStyles.purpleMedium16,
                                            ),
                                            Icon(
                                              Icons
                                                  .account_balance_wallet_outlined,
                                              color: AppColors.primaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (controller.approve.value ==
                                            'true') {
                                          Get.to(WithdrawView());
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        width: Get.width * 0.45,
                                        // alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          gradient: AppColors.goldGradient,
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Withdraw Points',
                                              style: BaseStyles.purpleMedium16,
                                            ),
                                            Icon(
                                              Icons
                                                  .remove_circle_outline_outlined,
                                              color: AppColors.pinkColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
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
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 6,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              // Top section with chart icon, market name, and close button
                                              Container(
                                                padding: EdgeInsets.all(16),
                                                child: Row(
                                                  children: [
                                                    // Chart icon on left
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                          '/chart?market_name=${item['market_name']}&market_slug=${item['market_slug']}',
                                                        );
                                                        toast(item[
                                                            'market_slug']);
                                                      },
                                                      child: Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.pink
                                                              .withOpacity(0.1),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Icon(
                                                          Icons.trending_up,
                                                          color: AppColors
                                                              .pinkColor,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 12),
                                                    // Market name and results in center
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            item['market_name']
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                          ),
                                                          SizedBox(height: 6),
                                                          Row(
                                                            children: [
                                                              // Open result
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            4),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .pink
                                                                      .withOpacity(
                                                                          0.1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Text(
                                                                  item['results'] ==
                                                                          null
                                                                      ? "***"
                                                                      : item['results']['open_pana'] ==
                                                                              null
                                                                          ? "***"
                                                                          : item['results']['open_pana'].length == 0
                                                                              ? "***"
                                                                              : item['results']['date'] == today
                                                                                  ? item['results']['open_pana']['text_value']
                                                                                  : "***",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColors
                                                                        .pinkColor,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(" - ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          16)),
                                                              // Close result
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            4),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .pink
                                                                      .withOpacity(
                                                                          0.1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Text(
                                                                  item['results'] ==
                                                                          null
                                                                      ? "***"
                                                                      : item['results']['close_pana'] ==
                                                                              null
                                                                          ? "***"
                                                                          : item['results']['close_pana'].length == 0
                                                                              ? "***"
                                                                              : item['results']['date'] == today
                                                                                  ? item['results']['close_pana']['text_value']
                                                                                  : "***",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColors
                                                                        .pinkColor,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // Status indicator on right
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (date.compareTo(
                                                                    closeDateCompair) <
                                                                0 &&
                                                            date.compareTo(
                                                                    opendateClose) >
                                                                0) {
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
                                                                      'regular',
                                                                  'market_type':
                                                                      item['market_type']
                                                                          .toString(),
                                                                  "item": item,
                                                                  "open": false,
                                                                  "close": true
                                                                });
                                                          } else {
                                                            Get.toNamed(
                                                                '/quiz');
                                                          }
                                                        } else {
                                                          if (date.compareTo(
                                                                  opendateClose) >
                                                              0) {
                                                            toast(
                                                                'Market is close');
                                                          } else {
                                                            if (controller
                                                                    .approve
                                                                    .value
                                                                    .toString() ==
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
                                                                        'regular',
                                                                    'market_type':
                                                                        item['market_type']
                                                                            .toString(),
                                                                    "item":
                                                                        item,
                                                                    "open":
                                                                        true,
                                                                    "close":
                                                                        true
                                                                  });
                                                            } else {
                                                              Get.toNamed(
                                                                  '/quiz');
                                                            }
                                                          }
                                                        }
                                                        if (date.compareTo(
                                                                    opendateClose) >
                                                                0 &&
                                                            date.compareTo(
                                                                    closeDateCompair) <
                                                                0) {
                                                          if (controller
                                                                  .approve.value
                                                                  .toString() ==
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
                                                                      'regular',
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
                                                          if (date.compareTo(
                                                                  closeDateCompair) <
                                                              0) {
                                                            if (controller
                                                                    .approve
                                                                    .value
                                                                    .toString() ==
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
                                                                        'regular',
                                                                    'market_type':
                                                                        item['market_type']
                                                                            .toString(),
                                                                    "item":
                                                                        item,
                                                                    "open":
                                                                        true,
                                                                    "close":
                                                                        true
                                                                  });
                                                            } else {
                                                              Get.toNamed(
                                                                  '/quiz');
                                                            }
                                                          } else {
                                                            toast(
                                                                'Market is close');
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                        width: 35,
                                                        height: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.1),
                                                              blurRadius: 4,
                                                              offset:
                                                                  Offset(0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Icon(
                                                          date.compareTo(
                                                                      closeDateCompair) <
                                                                  0
                                                              ? Icons.play_arrow
                                                              : Icons.close,
                                                          color: date.compareTo(
                                                                      closeDateCompair) <
                                                                  0
                                                              ? Colors.green
                                                              : Colors.red,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Market status text

                                              // Bottom pink bar with open/close times and play button
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.pinkColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 14),
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
                                                            color:
                                                                Colors.white70,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          openDate.toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // Play button
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 6,
                                                              vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            date.compareTo(
                                                                        closeDateCompair) <
                                                                    0
                                                                ? 'Market Running'
                                                                : 'Close for today',
                                                            style: TextStyle(
                                                              color: date.compareTo(
                                                                          closeDateCompair) <
                                                                      0
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .red[600],
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    // Close time
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "Close",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.white70,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          closeDate.toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
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
                    break;
                  case 1:
                    // Passbook - navigate to wallet history or transaction history
                    break;
                  case 2:
                    // Home/Center button - handled by floating action button
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
                  label: 'Passbook',
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
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Image.asset(ImagePath.LOGO)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    });
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
