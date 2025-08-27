// ignore: import_of_legacy_library_into_null_safe
import 'package:azmatka/app/modules/home/controllers/instruction_controller.dart';
import 'package:azmatka/constants/values.dart';
import 'package:flutter_html/flutter_html.dart';

class InstructionView extends GetView<InstructionController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => InstructionController());
    return Scaffold(
      appBar: AppBar(title: Text('About Us'), centerTitle: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => controller.loading.value
                ? Container(
                    height: Get.height,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      heightSpace20,
                      Container(
                        width: Get.width,
                        alignment: Alignment.center,
                        child: Image.asset(ImagePath.LOGO),
                      ),
                      heightSpace20,
                      Html(
                        data: controller.data['content'].toString(),
                      ),
                      heightSpace10,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
