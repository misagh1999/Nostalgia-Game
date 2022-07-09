import 'dart:convert';
import 'dart:math';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../widgets/dialog.dart';
import 'package:get/get.dart';

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

showUpdateDialogIfAvailable() async {
  final hasUpdate = await MyBackendApi().isUpdateAvailable();
  if (hasUpdate) {
    showUpdateDialog();
  }
}

class MyBackendApi extends GetConnect {
  Future<bool> isUpdateAvailable() async {
    final path = 'https://hobby.misaghpour-dev.ir/version';
    final response = await get(path);
    if (response.status.hasError) {
      return false;
    } else {
      final result = response.body;
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = int.parse(packageInfo.buildNumber);
      final lastVersionCode = result['last_version_code'] as int;
      if (lastVersionCode > currentVersion) {
        return true;
      } else {
        return false;
      }
    }
  }
}
