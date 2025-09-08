import 'package:azmatka/app/modules/home/controllers/games_controller.dart';
import 'package:azmatka/app/modules/home/views/game_bet_view.dart';
import 'package:azmatka/constants/values.dart';

class GamesView extends GetView<GamesController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GamesController());
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
        centerTitle: false,
      ),
      body: Obx(
        () => controller.loading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          controller.type == 'starline'
                              ? Container()
                              : design(
                                  title: 'SINGLE DIGIT',
                                  ontap: () {
                                    Get.to(() => GameBetView(), arguments: {
                                      'title': 'Single Digit',
                                      'id': '1',
                                      'gameId': controller.id,
                                      'appTitle': controller.title,
                                      'type': controller.type,
                                      'gameTypeId': controller.gameType[0]
                                              ['_id']
                                          .toString(),
                                      'market_type': controller.marketType,
                                      "item": controller.item,
                                      "open": controller.open,
                                      "close": controller.close
                                    });
                                  },
                                  childImage: controller.gameType[0]['image'],
                                ),
                          controller.type == 'starline'
                              ? Container()
                              : design(
                                  title: 'JODI DIGIT',
                                  ontap: () {
                                    Get.to(() => GameBetView(), arguments: {
                                      'title': 'Jodi Digit',
                                      'id': '2',
                                      'gameId': controller.id,
                                      'type': controller.type,
                                      'appTitle': controller.title,
                                      'market_type': controller.marketType,
                                      'gameTypeId': controller.gameType[1]
                                              ['_id']
                                          .toString(),
                                      "item": controller.item,
                                      "open": controller.open,
                                      "close": controller.close
                                    });
                                  },
                                  childImage: controller.gameType[1]['image'],
                                ),
                        ],
                      ),
                      controller.type != 'starline'
                          ? Container()
                          : design(
                              title: 'SINGLE DIGIT',
                              ontap: () {
                                Get.to(() => GameBetView(), arguments: {
                                  'title': 'Single Digit',
                                  'id': '1',
                                  'gameId': controller.id,
                                  'appTitle': controller.title,
                                  'type': controller.type,
                                  'market_type': controller.marketType,
                                  'gameTypeId':
                                      controller.gameType[0]['_id'].toString(),
                                  "item": controller.item,
                                  "open": controller.open,
                                  "close": controller.close
                                });
                              },
                              childImage: controller.gameType[0]['image'],
                            ),
                      heightSpace20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          design(
                            title: 'SINGLE PANA',
                            ontap: () {
                              Get.to(() => GameBetView(), arguments: {
                                'title': 'Single Pana',
                                'id': '3',
                                'gameId': controller.id,
                                'type': controller.type,
                                'appTitle': controller.title,
                                'market_type': controller.marketType,
                                'gameTypeId':
                                    controller.gameType[2]['_id'].toString(),
                                "item": controller.item,
                                "open": controller.open,
                                "close": controller.close
                              });
                            },
                            childImage: controller.gameType[2]['image'],
                          ),
                          design(
                            title: 'DOUBLE PANA',
                            ontap: () {
                              Get.to(() => GameBetView(), arguments: {
                                'title': 'Double Pana',
                                'id': '4',
                                'gameId': controller.id,
                                'type': controller.type,
                                'appTitle': controller.title,
                                'market_type': controller.marketType,
                                'gameTypeId':
                                    controller.gameType[3]['_id'].toString(),
                                "item": controller.item,
                                "open": controller.open,
                                "close": controller.close
                              });
                            },
                            childImage: controller.gameType[3]['image'],
                          ),
                        ],
                      ),
                      heightSpace20,
                      design(
                        title: 'TRIPLE PANA',
                        ontap: () {
                          Get.to(() => GameBetView(), arguments: {
                            'title': 'Triple Pana',
                            'id': '5',
                            'gameId': controller.id,
                            'type': controller.type,
                            'appTitle': controller.title,
                            'market_type': controller.marketType,
                            'gameTypeId':
                                controller.gameType[4]['_id'].toString(),
                            "item": controller.item,
                            "open": controller.open,
                            "close": controller.close
                          });
                        },
                        childImage: controller.gameType[4]['image'],
                      ),
                      heightSpace20,
                      controller.type == 'starline'
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                design(
                                  title: 'HALF SANGAM',
                                  ontap: () {
                                    Get.to(() => GameBetView(), arguments: {
                                      'title': 'Half Sangam',
                                      'id': '6',
                                      'gameId': controller.id,
                                      'type': controller.type,
                                      'appTitle': controller.title,
                                      'market_type': controller.marketType,
                                      'gameTypeId': controller.gameType[5]
                                              ['_id']
                                          .toString(),
                                      "item": controller.item,
                                      "open": controller.open,
                                      "close": controller.close
                                    });
                                  },
                                  childImage: controller.gameType[5]['image'],
                                ),
                                design(
                                  title: 'FULL SANGAM',
                                  ontap: () {
                                    Get.to(() => GameBetView(), arguments: {
                                      'title': 'Full Sangam',
                                      'id': '7',
                                      'gameId': controller.id,
                                      'type': controller.type,
                                      'appTitle': controller.title,
                                      'market_type': controller.marketType,
                                      'gameTypeId': controller.gameType[6]
                                              ['_id']
                                          .toString(),
                                      "item": controller.item,
                                      "open": controller.open,
                                      "close": controller.close
                                    });
                                  },
                                  childImage: controller.gameType[6]['image'],
                                ),
                              ],
                            ),
                      heightSpace20,
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget design(
      {required title, required Function() ontap, required childImage}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 150,
        width: 150,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(ImagePath.star),
        //     fit: BoxFit.fill,
        //   ),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://winbazar.store/uploads/game_type/" + childImage,
              height: 100,
              fit: BoxFit.fill,
            ),
            Text(title, style: BaseStyles.blackMedium14)
          ],
        ),
      ),
    );
  }
}
