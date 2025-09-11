import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:azmatka/constants/values.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWidgets {
  static Padding navBarImage({String? path, double? height}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Image.asset(
        path ?? '',
        height: height,
      ),
    );
  }

  static const getDrawerDivider = Divider(
    height: 4,
  );

  static Widget circularProgressIndicator(
          {Color color = AppColors.primaryColor}) =>
      Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      );

  static BottomNavigationBarItem navBarItem({
    required Widget icon,
    required Widget activeIcon,
    String? label,
  }) {
    return BottomNavigationBarItem(
      icon: icon,
      activeIcon: activeIcon,
      label: label,
    );
  }

  Widget buildMaterialBtnwithWidth({
    required String text,
    required Function()? onPressed,
    Color textColor = Colors.black,
    width,
    double? height,
    double? fontSize,
    Color color = AppColors.whiteColor,
  }) {
    return MaterialButton(
      height: height ?? 45,
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 1,
      minWidth: width,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color == AppColors.primaryColor
              ? AppColors.whiteColor
              : textColor,
          fontSize: fontSize ?? 25,
        ),
      ),
    );
  }

  buildTextFormField({
    TextEditingController? controller,
    String? Function(String?)? validator,
    String? labelText,
    String? hintText,
    bool obscureText = false,
    Widget? suffixIcon,
    backgroundColor,
    Widget? prefixIcon,
    TextInputType? keyboardType = TextInputType.text,
    required bool darkMode,
    bool enabled = true,
    bool filled = false,
    bool readOnly = false,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: AppColors.whiteColor),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: controller,
        validator: validator,
        readOnly: readOnly,
        obscureText: obscureText,
        keyboardType: keyboardType,
        enabled: enabled,
        style: TextStyle(color: AppColors.whiteColor, fontSize: 18),
        decoration: InputDecoration(
          fillColor: AppColors.lightGrey,
          filled: filled,
          errorStyle: darkMode
              ? TextStyle(
                  color: AppColors.whiteColor, fontWeight: FontWeight.bold)
              : null,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white70),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  buildTextFormFieldWithLabel({
    TextEditingController? controller,
    String? Function(String?)? validator,
    String? labelText,
    String? hintText,
    bool obscureText = false,
    Widget? suffixIcon,
    bool? readOnly,
    int? maxLength,
    TextStyle? labelStyle,
    Widget? prefixIcon,
    Function()? ontap,
    Function(String s)? onchanged,
    TextInputType? keyboardType = TextInputType.text,
    required bool darkMode,
    bool enabled = true,
    bool filled = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText ?? '', style: labelStyle ?? BaseStyles.primaryMedium16),
        heightSpace5,
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryAccentColor),
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: controller,
            validator: validator,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onTap: ontap,
            onChanged: onchanged,
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxLength),
            ],
            enabled: enabled,
            readOnly: readOnly ?? false,
            style: darkMode
                ? const TextStyle(color: Colors.white, fontSize: 18)
                : const TextStyle(color: Colors.black, fontSize: 18),
            decoration: InputDecoration(
              fillColor: AppColors.lightGrey,
              filled: filled,
              contentPadding: EdgeInsets.all(10),
              errorStyle: darkMode
                  ? TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold)
                  : null,
              hintText: hintText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAccountTextField({
    TextEditingController? controller,
    String? Function(String?)? validator,
    String? labelText,
    int? maxLines,
    String? hintText,
    bool obscureText = false,
    Widget? prefix,
    TextInputType? keyboardType = TextInputType.text,
    bool enabled = true,
    bool filled = false,
    String? initialValue,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      obscureText: obscureText,
      initialValue: initialValue,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: filled,
        fillColor: AppColors.lightGrey,
        prefix: prefix,
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.lightGrey,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  AppBar getAppBar({
    required String title,
  }) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Acumin Pro',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget appTitle({double height = 80}) {
    return Align(
      alignment: Alignment.topCenter,
    );
  }

  static Widget appTitleLogin({double height = 80}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
    );
  }

  Widget buildMaterialBtn({
    required String text,
    required Function()? onPressed,
    double? height,
    double? radius,
    Color textColor = Colors.white,
    Color color = AppColors.whiteColor,
  }) {
    return MaterialButton(
      height: height ?? 45,
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 4),
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

  Widget chartCard({required String day, required Map<dynamic, dynamic> data}) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.whiteColor, width: 1)),
      child: Center(
        child: Column(children: [
          SizedBox(
            height: 4,
          ),
          Text(
            "${day}",
            style:
                GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            "${data['date']}",
            textAlign: TextAlign.center,
            style:
                GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: AppColors.whiteColor, width: 1))),
            padding: EdgeInsets.only(top: 4),
            child: Center(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${data['open'] != null ? data['open'][0] + '\n' + data['open'][1] + '\n' + data['open'][2] : ''}',
                      style: GoogleFonts.roboto(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${data['digit'] != null ? data['digit'] : ''}',
                      style: GoogleFonts.roboto(
                          fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '${data['close'] != null ? data['close'][0] + '\n' + data['close'][1] + '\n' + data['close'][2] : ''}',
                      style: GoogleFonts.roboto(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}

SizedBox widthSpace10 = SizedBox(width: 10.0);
SizedBox heightSpace10 = SizedBox(height: 10.0);
SizedBox heightSpace5 = SizedBox(height: 5.0);
SizedBox widthSpace5 = SizedBox(width: 5.0);
SizedBox widthSpace20 = SizedBox(width: 20.0);
SizedBox widthSpace30 = SizedBox(width: 30.0);
SizedBox heightSpace20 = SizedBox(height: 20.0);
SizedBox heightSpace50 = SizedBox(height: 50.0);
SizedBox heightSpace30 = SizedBox(height: 30.0);
SizedBox heightSpace40 = SizedBox(height: 40.0);
SizedBox heightSpace60 = SizedBox(height: 60.0);

toast(msg) {
  Fluttertoast.showToast(msg: msg);
}
