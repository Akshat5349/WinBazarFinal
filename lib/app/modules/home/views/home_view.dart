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
          title: Text("Kalyan365 App"),
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
                                    color: AppColors.pinkColor,
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
                                        style: BaseStyles.whiteMedium16,
                                      ),
                                      Icon(
                                        Icons.language,
                                        color: Colors.white,
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
                                    color: AppColors.pinkColor,
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
                                        'Call Now',
                                        style: BaseStyles.whiteMedium16,
                                      ),
                                      Icon(
                                        Icons.phone,
                                        color: Colors.white,
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
                                          color: AppColors.pinkColor,
                                          // gradient: LinearGradient(colors: [Colors.red,Colors.black,Colors.red],begin: Alignment.topCenter,end: Alignment.bottomCenter),
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
                                              style: BaseStyles.whiteMedium16,
                                            ),
                                            Icon(
                                              Icons
                                                  .account_balance_wallet_outlined,
                                              color: Colors.white,
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
                                          color: AppColors.pinkColor,
                                          // gradient: LinearGradient(colors: [Colors.red,Colors.black,Colors.red],begin: Alignment.topCenter,end: Alignment.bottomCenter),
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
                                              style: BaseStyles.whiteMedium16,
                                            ),
                                            Icon(
                                              Icons
                                                  .remove_circle_outline_outlined,
                                              color: Colors.white,
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
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.pinkColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10))),
                                                height: 30,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      "Open-" +
                                                          openDate.toString(),
                                                      style: BaseStyles
                                                          .whiteMedium16,
                                                    ),
                                                    Text(
                                                      "Close-" +
                                                          closeDate.toString(),
                                                      style: BaseStyles
                                                          .whiteMedium16,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                height: 80,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                          '/chart?market_name=${item['market_name']}&market_slug=${item['market_slug']}',
                                                        );
                                                        toast(item[
                                                            'market_slug']);
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: Center(
                                                          child: Image.asset(
                                                            IconPath.graph,
                                                            height: 50,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          width: 7,
                                                        ),
                                                        Text(
                                                          item['market_name']
                                                              .toString(),
                                                          style: BaseStyles
                                                              .blackBold18
                                                              .copyWith(
                                                                  fontSize: 20),
                                                        ),
                                                        //   heightSpace20,

                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 4),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                item['results'] ==
                                                                        null
                                                                    ? Text(
                                                                        "****",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold))
                                                                    : item['results']['open_pana'] ==
                                                                            null
                                                                        ? Text(
                                                                            "_**",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold))
                                                                        : item['results']['open_pana'].length == 0
                                                                            ? Text("_**")
                                                                            : Text(item['results']['date'] == today ? item['results']['open_pana']['text_value'] : "****", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                item['results'] ==
                                                                        null
                                                                    ? Text(
                                                                        "***",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold))
                                                                    : item['results']['close_pana'] ==
                                                                            null
                                                                        ? Text(
                                                                            "_**",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold))
                                                                        : item['results']['close_pana'].length == 0
                                                                            ? Text("_**", style: TextStyle(fontWeight: FontWeight.bold))
                                                                            : Text(item['results']['date'] == today ? item['results']['close_pana']['text_value'] : "****", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                SizedBox(
                                                                  width: 7,
                                                                ),
                                                              ],
                                                            )),
                                                        Container(
                                                          height: 20,
                                                          color: Colors.white,
                                                          child: Text(
                                                            date.compareTo(
                                                                        closeDateCompair) <
                                                                    0
                                                                ? 'Market Running'
                                                                : 'Market is Close',
                                                            style: date.compareTo(
                                                                        closeDateCompair) <
                                                                    0
                                                                ? BaseStyles
                                                                    .blackMedium16
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .green,
                                                                  )
                                                                : BaseStyles
                                                                    .blackMedium16
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 7,
                                                        ),
                                                      ],
                                                    ),
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
                                                            //  toast('Market not open');
                                                          } else {
                                                            toast(
                                                                'Market is close');
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: Center(
                                                            child: Icon(Icons
                                                                .play_arrow)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7,
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
