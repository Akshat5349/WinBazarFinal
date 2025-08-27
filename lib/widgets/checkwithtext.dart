import 'package:azmatka/constants/values.dart';

Row checkwithText(
    {required txt, controller, required int selectvalue, bool? temp}) {
  return Row(
    children: [
      Radio(
          activeColor: AppColors.primaryAccentColor,
          value: selectvalue,
          groupValue: controller.value,
          onChanged: (index) {
            !temp! ? "" : controller.value = selectvalue;

          }),
      Text(
        txt,
        style: BaseStyles.blackMedium16,
      ),
    ],
  );
}
