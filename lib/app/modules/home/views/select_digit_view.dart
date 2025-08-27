import 'package:azmatka/app/modules/home/controllers/game_bet_controller.dart';
import 'package:azmatka/app/modules/home/controllers/select_digit_controller.dart';
import 'package:azmatka/constants/values.dart';

class SelectDigitView extends GetView<SelectDigitController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SelectDigitController());
    Get.lazyPut(() => GameBetController());
    var item2 = Get.find<GameBetController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Digit'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(
          () => Column(
            children: [
              CustomWidgets().buildTextFormFieldWithLabel(
                darkMode: false,
                hintText: 'Enter Digit',
                maxLength: controller.id == '1'
                    ? 1
                    : controller.id == '2'
                        ? 2
                        : 3,
                onchanged: (value) {
                  controller.search(value);
                },
                keyboardType: TextInputType.number,
                labelText: 'Digit',
              ),
              heightSpace20,
              controller.loading.value
                  ? CircularProgressIndicator()
                  : controller.digit.length == 0
                      ? Container()
                      : Expanded(
                          child: ListView.builder(
                            itemCount: controller.digit.length,
                            itemBuilder: (context, index) {
                              var item = controller.digit[index];
                              // print(controller.digit.length);
                              return GestureDetector(
                                onTap: () {
                                  controller.valueFor=='Digit'?
                                  item2.digitContoller.text = item.toString():
                                  controller.valueFor=='Open Digit'?
                                  item2.openDigitContoller.text = item.toString():
                                  controller.valueFor=='Close Digit'?
                                  item2.closeDigitContoller.text = item.toString():
                                  controller.valueFor=='Open Pana'?
                                  item2.openPanaContoller.text = item.toString():
                                  controller.valueFor=='Close Pana'?
                                  item2.closePanaContoller.text = item.toString():
                                  item2.digitContoller.text = item.toString();

                                  Get.back();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.black54)),
                                  child: Text(
                                    item.toString(),
                                    style: BaseStyles.blackBold18,
                                  ),
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
