import '../constants/values.dart';

enum ButtonType { primary, success, warning, error, outlined, text }

class ModernAppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double? height;
  final bool isFullWidth;
  final double borderRadius;
  final EdgeInsets padding;

  const ModernAppButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height,
    this.isFullWidth = false,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : width,
      height: height ?? 56,
      decoration: BoxDecoration(
        gradient: _getGradient(),
        borderRadius: BorderRadius.circular(borderRadius),
        border: type == ButtonType.outlined
            ? Border.all(
                color: AppColors.primaryColor,
                width: 2,
              )
            : null,
        boxShadow: type != ButtonType.text && type != ButtonType.outlined
            ? [
                BoxShadow(
                  color: _getShadowColor().withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: padding,
            decoration: type == ButtonType.text || type == ButtonType.outlined
                ? null
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading) ...[
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        type == ButtonType.outlined || type == ButtonType.text
                            ? AppColors.primaryColor
                            : AppColors.whiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ] else if (icon != null) ...[
                  Icon(
                    icon,
                    color: _getTextColor(),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Text(
                    text,
                    style: _getTextStyle(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient? _getGradient() {
    if (type == ButtonType.outlined || type == ButtonType.text) {
      return null;
    }

    switch (type) {
      case ButtonType.primary:
        return AppColors.primaryGradient;
      case ButtonType.success:
        return AppColors.successGradient;
      case ButtonType.warning:
        return AppColors.warningGradient;
      case ButtonType.error:
        return AppColors.errorGradient;
      default:
        return AppColors.primaryGradient;
    }
  }

  Color _getShadowColor() {
    switch (type) {
      case ButtonType.primary:
        return AppColors.primaryColor;
      case ButtonType.success:
        return AppColors.successColor;
      case ButtonType.warning:
        return AppColors.warningColor;
      case ButtonType.error:
        return AppColors.errorColor;
      default:
        return AppColors.primaryColor;
    }
  }

  Color _getTextColor() {
    if (type == ButtonType.outlined || type == ButtonType.text) {
      switch (type == ButtonType.text ? ButtonType.primary : type) {
        case ButtonType.primary:
          return AppColors.primaryColor;
        case ButtonType.success:
          return AppColors.successColor;
        case ButtonType.warning:
          return AppColors.warningColor;
        case ButtonType.error:
          return AppColors.errorColor;
        default:
          return AppColors.primaryColor;
      }
    }
    return AppColors.whiteColor;
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      color: _getTextColor(),
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    );
  }
}

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
              style: style ?? BaseStyles.primaryMedium16,
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
          style: style ?? BaseStyles.primaryMedium16,
        ),
      ),
    );
  }
}
