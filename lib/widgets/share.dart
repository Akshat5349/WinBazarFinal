// ignore_for_file: deprecated_member_use

import 'package:url_launcher/url_launcher.dart';

Future<void> launchurl(String url) async {
  if (!await launch(
    url,
  )) {
    throw 'Could not launch $url';
  }
}

Future<void> launchWhatsapp(String url) async {
  if (!await launch(
    "https://wa.me/$url",
  )) {
    throw 'Could not launch $url';
  }
}

Future<void> launchPlaystore(String url) async {
  if (!await launch(
    url,
    forceSafariVC: false,
    forceWebView: false,
    headers: <String, String>{'my_header_key': 'my_header_value'},
  )) {
    throw 'Could not launch $url';
  }
}
