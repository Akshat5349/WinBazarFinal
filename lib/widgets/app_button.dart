import '../constants/values.dart';

class AppButton {
  Widget buildMaterialBtn({
    required String text,
    required Function()? onPressed,
    Color textColor = Colors.black,
    Color color = AppColors.whiteColor,
  }) {
    return MaterialButton(
      height: 45,
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      elevation: 1,
      minWidth: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Acumin Pro',
          fontWeight: FontWeight.w700,
          color: color == AppColors.primaryColor
              ? AppColors.whiteColor
              : textColor,
          fontSize: 16,
        ),
      ),
    );
  }

  GestureDetector btnWithIcon(
      {required BuildContext context,
      Function()? onTap,
      text,
      TextStyle? style}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.primaryColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/bitcoin.png",
              height: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: style ?? BaseStyles.purpleMedium16,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector btn(
      {required BuildContext context,
      Function()? onTap,
      width,
      required text,
      color,
      TextStyle? style}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? Get.width,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color ?? AppColors.whiteColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.primaryColor)),
        child: Text(
          text,
          style: style ?? BaseStyles.purpleMedium16,
        ),
      ),
    );
  }
}
