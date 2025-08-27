import 'package:azmatka/app/modules/home/controllers/starline_controller.dart';
import 'package:azmatka/app/modules/home/views/bid_history_view.dart';
import 'package:azmatka/app/modules/home/views/games_view.dart';
import 'package:azmatka/app/modules/home/views/winning_history_view.dart';
import 'package:azmatka/constants/values.dart';

class StarlineView extends GetView<StarlineController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => StarlineController());
    controller.starlineApi();
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text('Starline Games'),
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: controller.starlineApi,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    heightSpace30,
                    Row(
                      children: [
                        widthSpace10,
                        Image.asset(
                          ImagePath.LOGO,
                          height: 100,
                          width: 100,
                        ),
                        widthSpace10,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '*Single Digit :- 10 - 100',
                                style: BaseStyles.whiteNormal16,
                              ),
                              heightSpace10,
                              Text(
                                '*Single Panna :- 10 - 1600',
                                style: BaseStyles.whiteNormal16,
                              ),
                              heightSpace10,
                              Text(
                                '*Double Panna :- 10 - 3200',
                                style: BaseStyles.whiteNormal16,
                              ),
                              heightSpace10,
                              Text(
                                '*Triple Panna :- 10 - 7000',
                                style: BaseStyles.whiteNormal16,
                              ),
                              heightSpace10,
                            ],
                          ),
                        )
                      ],
                    ),
                    heightSpace10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => BidHistoryView(), arguments: {
                              'type': 'starline',
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: Get.width * 0.45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              'Bid History',
                              style: BaseStyles.whiteMedium20,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => WinningHistoryView(),
                                arguments: {'type': 'starline'});
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: Get.width * 0.45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              'Win History',
                              style: BaseStyles.whiteMedium16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(
                () => controller.loading.value
                    ? CircularProgressIndicator()
                    : controller.market.length == 0
                        ? Text('No Market Available')
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.market.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var item = controller.market[index];
                              return Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.9,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                ImagePath.task,
                                                height: 60,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    item['market_name']
                                                        .toString(),
                                                    style: BaseStyles
                                                        .purplebold25
                                                        .copyWith(fontSize: 20),
                                                  ),
                                                  Text(
                                                    item['is_play']
                                                                .toString() ==
                                                            '1'
                                                        ? '*******'
                                                        : '470-28-477',
                                                    style: BaseStyles
                                                        .blackMedium16,
                                                  ),
                                                  Text(
                                                    item['is_play']
                                                                .toString() ==
                                                            '1'
                                                        ? 'Open'
                                                        : 'Betting is closed for today',
                                                    style: item['is_play']
                                                                .toString() ==
                                                            '1'
                                                        ? BaseStyles
                                                            .blackMedium16
                                                            .copyWith(
                                                            color: Colors.green,
                                                          )
                                                        : BaseStyles
                                                            .blackMedium16
                                                            .copyWith(
                                                            color: Colors.red,
                                                          ),
                                                  )
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: item['is_play']
                                                            .toString() ==
                                                        '0'
                                                    ? () {
                                                        toast(
                                                            'Sorry.. Market is closed for today');
                                                      }
                                                    : () {
                                                        Get.to(
                                                            () => GamesView(),
                                                            arguments: {
                                                              'id': item['_id']
                                                                  .toString(),
                                                              'name': item[
                                                                      'market_name']
                                                                  .toString(),
                                                              'type':
                                                                  'starline',
                                                              'market_type':
                                                                  item['market_type']
                                                                      .toString()
                                                            });
                                                      },
                                                child: Image.asset(
                                                  ImagePath.video,
                                                  height: 60,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        heightSpace20,
                                        SizedBox(
                                          width: Get.width * 0.8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Text(
                                              //   'Open - ${item['Opentime'].toString()}',
                                              //   style: BaseStyles.blackMedium16,
                                              // ),
                                              Text(
                                                'Close - ${item['time'].toString()}',
                                                style: BaseStyles.blackMedium16,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
