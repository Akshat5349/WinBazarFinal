import 'package:audioplayers/audioplayers.dart';
import 'package:azmatka/app/modules/home/controllers/game_bet_controller.dart';
import 'package:azmatka/app/modules/home/views/select_digit_view.dart';
import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/checkwithtext.dart';
import 'package:flutter/services.dart';

class GameBetView extends GetView<GameBetController> {
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playBellSound();
    });
    Get.lazyPut(() => GameBetController());
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.appTitle} (${controller.title})'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomWidgets().buildTextFormFieldWithLabel(
                darkMode: false,
                labelText: 'Choose Date',
                hintText: 'Select Date',
                readOnly: true,
                controller: controller.dateContoller,
                prefixIcon: IconButton(
                    onPressed: () {
                      // showDatePicker(
                      //   initialDate: DateTime.now(),
                      //   firstDate: DateTime.now(),
                      //   lastDate: DateTime.now().add(Duration(days: 5)),
                      //   context: context,
                      // ).then((pickedDate) {
                      //   String formattedDate =
                      //       DateFormat('dd-MM-yyyy').format(pickedDate!);
                      //   return controller.dateContoller.text = formattedDate;
                      // });
                    },
                    icon: Icon(
                      Icons.calendar_month,
                    ))),
            controller.type == 'starline'
                ? Container()
                : controller.title == 'Jodi Digit' ||
                        controller.title == 'Full Sangam'
                    ? Container()
                    : heightSpace20,
            controller.type == 'starline'
                ? Container()
                : controller.title == 'Jodi Digit' ||
                        controller.title == 'Full Sangam'
                    ? Container()
                    : Text('Choose session', style: BaseStyles.purpleMedium16),
            heightSpace5,
            controller.type == 'starline'
                ? Container()
                : controller.title == 'Jodi Digit' ||
                        controller.title == 'Full Sangam'
                    ? Container()
                    : Container(
                        width: Get.width,
                        height: 45,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.primaryAccentColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Obx(
                          () => Row(
                            children: [
                              checkwithText(
                                  temp: controller.open,
                                  controller: controller.selectvalue,
                                  selectvalue: 1,
                                  txt: controller.marketType == 'Jodi'
                                      ? 'Left Digit'
                                      : 'Open'),
                              widthSpace30,
                              checkwithText(
                                  temp: controller.close,
                                  controller: controller.selectvalue,
                                  selectvalue: 2,
                                  txt: controller.marketType == 'Jodi'
                                      ? 'Right Digit'
                                      : 'Close'),
                            ],
                          ),
                        ),
                      ),
            heightSpace20,
            (controller.title == 'Half Sangam') ||
                    controller.title == 'Full Sangam'
                ? Obx(() => controller.selectvalue.value == 1 ||
                        controller.title == 'Full Sangam'
                    ? CustomWidgets().buildTextFormFieldWithLabel(
                        darkMode: false,
                        hintText: 'Enter Open Pana',
                        labelText: 'Open Pana',
                        controller: controller.openPanaContoller,
                        readOnly: true,
                        ontap: () {
                          Get.to(() => SelectDigitView(), arguments: {
                            'id': controller.id,
                            'valueFor': 'Open Pana'
                          });
                        })
                    : Container())
                : Container(),
            (controller.title == 'Half Sangam') ||
                    controller.title == 'Full Sangam'
                ? Obx(() => (controller.selectvalue.value == 2 ||
                        controller.title == 'Full Sangam')
                    ? CustomWidgets().buildTextFormFieldWithLabel(
                        darkMode: false,
                        hintText: 'Enter Close Pana',
                        labelText: 'Close Pana',
                        controller: controller.closePanaContoller,
                        readOnly: true,
                        ontap: () {
                          Get.to(() => SelectDigitView(), arguments: {
                            'id': controller.id,
                            'valueFor': 'Close Pana'
                          });
                        })
                    : Container())
                : Container(),
            controller.title == 'Full Sangam' ? Container() : heightSpace20,
            controller.title == 'Full Sangam'
                ? Container()
                : controller.title == 'Half Sangam'
                    ? Obx(() => controller.selectvalue.value == 1
                        ? CustomWidgets().buildTextFormFieldWithLabel(
                            darkMode: false,
                            hintText: 'Enter Close Digit',
                            labelText: 'Close Digit',
                            controller: controller.closeDigitContoller,
                            readOnly: true,
                            ontap: () {
                              Get.to(() => SelectDigitView(), arguments: {
                                'id': '1',
                                'valueFor': 'Close Digit'
                              });
                            })
                        : CustomWidgets().buildTextFormFieldWithLabel(
                            darkMode: false,
                            hintText: 'Enter Open Digit',
                            labelText: 'Open Digit',
                            controller: controller.openDigitContoller,
                            readOnly: true,
                            ontap: () {
                              Get.to(() => SelectDigitView(), arguments: {
                                'id': '1',
                                'valueFor': 'Open Digit'
                              });
                            }))
                    : CustomWidgets().buildTextFormFieldWithLabel(
                        darkMode: false,
                        hintText: 'Enter Digits',
                        labelText: 'Digits',
                        controller: controller.digitContoller,
                        readOnly: true,
                        ontap: () {
                          Get.to(() => SelectDigitView(), arguments: {
                            'id': controller.id,
                            'valueFor': 'Digit'
                          });
                        }),
            heightSpace20,
            CustomWidgets().buildTextFormFieldWithLabel(
              darkMode: false,
              hintText: 'Enter Points',
              labelText: 'Points',
              keyboardType: TextInputType.number,
              controller: controller.pointContoller,
            ),
            heightSpace40,
            CustomWidgets().buildMaterialBtn(
                text: 'SUBMIT',
                onPressed: () {
                  controller.submitApi();
                },
                color: AppColors.pinkColor,
                radius: 12)
          ],
        ),
      ),
    );
  }

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
}
