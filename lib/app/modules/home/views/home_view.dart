import 'package:audioplayers/audioplayers.dart';
import 'package:azmatka/app/modules/home/views/bid_history_view.dart';
import 'package:azmatka/app/modules/home/views/gali_disawar_view.dart';
import 'package:azmatka/app/modules/home/views/games_view.dart';
import 'package:azmatka/app/modules/home/views/notice_view.dart';
import 'package:azmatka/app/modules/home/views/payment_screen.dart';
import 'package:azmatka/app/modules/home/views/wallet_view.dart';
import 'package:azmatka/app/modules/home/views/winning_history_view.dart';
import 'package:azmatka/app/modules/home/views/withdraw_view.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/base_url.dart';
import 'package:azmatka/widgets/main_drawer.dart';
import 'package:azmatka/widgets/share.dart';
import 'package:azmatka/widgets/custom_widgets.dart';
import 'package:azmatka/services/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

// Custom Marquee Text Widget
class MarqueeText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final double speed;

  const MarqueeText({
    Key? key,
    required this.text,
    required this.style,
    this.speed = 50,
  }) : super(key: key);

  @override
  _MarqueeTextState createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 15),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: -1.0).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset:
              Offset(_animation.value * MediaQuery.of(context).size.width, 0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.campaign,
                  color: Color(0xFFd4af37),
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  widget.text,
                  style: widget.style,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es');
    var now = DateTime.now();
    var today = DateFormat.yMd('es').format(now);
    Get.lazyPut(() => HomeController());
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: Text("Royal", style: BaseStyles.whiteMedium20),
          centerTitle: false,
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
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
            SizedBox(width: 8),
          ],
        ),
        drawer: MainDrawer(
          approved: controller.approve.value,
        ),
        body: controller.homeLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              )
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

                    // Marquee text scrolling from right to left
                    Container(
                      height: 20,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        // gradient: LinearGradient(
                        //   colors: [
                        //     Color(0xFF1a2332),
                        //     Color(0xFF2a3441),
                        //   ],
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        // ),
                        borderRadius: BorderRadius.circular(8),
                        // border: Border.all(
                        //   color: Color(0xFFd4af37),
                        //   width: 1,
                        // ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: MarqueeText(
                          text: Strings.settings[0].movingText.toString(),
                          style: TextStyle(
                            color: Colors.red[400],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          speed: 50,
                        ),
                      ),
                    ),

                    Container(
                      child: Column(children: [
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
                        // Action buttons with modern design
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // WhatsApp button
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: InkWell(
                                    onTap: () {
                                      SystemSound.play(SystemSoundType.click);
                                      launchWhatsapp(
                                          '+91${Strings.settings[0].whatsapp.toString()}');
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF25D366),
                                            Color(0xFF128C7E)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFF25D366)
                                                .withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImagePath.whatsapp,
                                            height: 20,
                                            width: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'WhatsApp',
                                            style: TextStyle(
                                              color: AppColors.whiteColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Gali Disawar button
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: InkWell(
                                    onTap: () {
                                      SystemSound.play(SystemSoundType.click);
                                      Get.to(() => GaliDisawarView());
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      decoration: BoxDecoration(
                                        gradient: AppColors.primaryGradient,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primaryColor
                                                .withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.casino_outlined,
                                            color: AppColors.whiteColor,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Gali Disawar',
                                            style: TextStyle(
                                              color: AppColors.whiteColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Payment and withdraw buttons
                        controller.approve.value == 'true'
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Add Money button
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 8),
                                        child: InkWell(
                                          onTap: () {
                                            SystemSound.play(
                                                SystemSoundType.click);
                                            if (controller.approve.value ==
                                                'true') {
                                              Get.to(PaymentScreen());
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16),
                                            decoration: BoxDecoration(
                                              gradient:
                                                  AppColors.successGradient,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.successColor
                                                      .withOpacity(0.3),
                                                  blurRadius: 8,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add_circle_outline,
                                                  color: AppColors.whiteColor,
                                                  size: 20,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  'Add Money',
                                                  style: TextStyle(
                                                    color: AppColors.whiteColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Withdraw button
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: InkWell(
                                          onTap: () {
                                            SystemSound.play(
                                                SystemSoundType.click);
                                            if (controller.approve.value ==
                                                'true') {
                                              Get.to(WithdrawView());
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16),
                                            decoration: BoxDecoration(
                                              gradient:
                                                  AppColors.warningGradient,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.warningColor
                                                      .withOpacity(0.3),
                                                  blurRadius: 8,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.remove_circle_outline,
                                                  color: AppColors.whiteColor,
                                                  size: 20,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  'Withdraw',
                                                  style: TextStyle(
                                                    color: AppColors.whiteColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
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
                                                                    ? "***"
                                                                    : item['results']['open_pana'] ==
                                                                            null
                                                                        ? "***"
                                                                        : item['results']['open_pana'].length ==
                                                                                0
                                                                            ? "***"
                                                                            : item['results']['date'] == today
                                                                                ? item['results']['open_pana']['text_value']
                                                                                : "***",
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
                                                                    ? "***"
                                                                    : item['results']['close_pana'] ==
                                                                            null
                                                                        ? "***"
                                                                        : item['results']['close_pana'].length ==
                                                                                0
                                                                            ? "***"
                                                                            : item['results']['date'] == today
                                                                                ? item['results']['close_pana']['text_value']
                                                                                : "***",
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
                                                              color: AppColors
                                                                  .blackColor,
                                                              fontSize: 11,
                                                            ),
                                                          ),
                                                          Text(
                                                            closeDate
                                                                .toString(),
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
              selectedItemColor: Colors.grey[600],
              unselectedItemColor: Colors.grey[600],
              selectedFontSize: 10,
              unselectedFontSize: 10,
              currentIndex: 0, // Default to home/My Bids
              onTap: (index) {
                SystemSound.play(SystemSoundType.click);
                switch (index) {
                  case 0:
                    // My Bids - stay on current page or navigate to bids page
                    Get.to(() => BidHistoryView(), arguments: {
                      'type': 'regular',
                    });
                    break;
                  case 1:
                    // Passbook - navigate to wallet history or transaction history
                    if (controller.approve.value == 'true') {
                      Get.to(() => WalletView());
                    }
                    break;
                  case 2:
                    // Home/Center button - handled by floating action button
                    Get.offAll(() => HomeView());
                    break;
                  case 3:
                    // Funds - navigate to wallet/payment screen
                    Get.to(() => WinningHistoryView(), arguments: {
                      'type': 'regular',
                    });
                    break;
                  case 4:
                    // Support - navigate to support/contact page
                    launchWhatsapp(
                        '+91${Strings.settings[0].whatsapp.toString()}');
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
                  label: 'Wallet',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox.shrink(), // Empty for center FAB
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_events, size: 24),
                  label: 'Win History',
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
