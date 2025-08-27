import 'package:get_storage/get_storage.dart';

var box = GetStorage();

class Auth {
  token() async {
    var box = GetStorage();
    return box.read('token') ?? '';
  }
}

userId() {
  return box.read('user_id') ?? '';
}

paymentStatus() {
  return box.read('paymentStatus') ?? '';
}

upiId() {
  return box.read('upiId') ?? '';
}

deviceId() {
  return box.read('device_id') ?? '';
}

deviceName() {
  return box.read('device_name') ?? '';
}

deviceModel() {
  return box.read('device_model') ?? '';
}

appId() {
  return 'com.shyam.matka';
}

userName() {
  return box.read('name') ?? '';
}

mobileNumber() {
  return box.read('mobile') ?? '';
}
