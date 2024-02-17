import 'dart:math';

import 'package:package_info_plus/package_info_plus.dart';

String replacePersianNum(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], farsi[i]);
  }

  return input;
}

randomNumber(int start, int finish) {
  final startInt = start;
  final endInt = finish;
  Random random = Random();
  return random.nextInt(endInt + 1 - startInt) + startInt;
}

getVersionNumber() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  return version;
}
