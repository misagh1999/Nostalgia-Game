import 'dart:math';

import 'package:package_info_plus/package_info_plus.dart';

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
