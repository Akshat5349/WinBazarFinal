import 'package:flutter/material.dart';
import 'package:get/get.dart';

pleaseWait() {
  Get.defaultDialog(
    title: 'Plese Wait...',
    custom: const CircularProgressIndicator(),
    content: const CircularProgressIndicator(),
    barrierDismissible: false,
    onWillPop: () async {
      return true;
    },
  );
}
