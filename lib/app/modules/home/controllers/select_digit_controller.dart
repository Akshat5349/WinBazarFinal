import 'package:azmatka/constants/values.dart';
import 'package:azmatka/widgets/numbers.dart';

class SelectDigitController extends GetxController {
  TextEditingController SelectController = TextEditingController();
  var id = int.parse(Get.arguments['id']);
  var valueFor = Get.arguments['valueFor'];
  final digit = [].obs;
  final loading = false.obs;
  @override
  void onInit() {
    super.onInit();

    digit.addAll(id == 1
        ? singleDigit
        : id == 2
            ? jodiDigit
            : id == 3
                ? singlePana
                : id == 4
                    ? doublePana
                    : id == 5 
                    ? triplePana
                    : halfSangamClose);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  search(String value) {
    var data = (id == 1
        ? singleDigit
        : id == 2
            ? jodiDigit
            : id == 3
                ? singlePana
                : id == 4
                    ? doublePana
                    : id == 5 
                    ? triplePana
                    : halfSangamClose)
        .where((row) => (row.contains(value)));
    if (data.length >= 1) {
      digit.clear();
      digit.addAll(data.toList() as dynamic);

      return data.toList();
    } else {
      digit.clear();
      return 'No Data Found';
    }
  }
}
