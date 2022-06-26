import 'package:package_info_plus/package_info_plus.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../widgets/dialog.dart';

String replacePersianNum(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], farsi[i]);
  }

  return input;
}

getVersionNumber() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  return version;
}

showUpdateDialogIfAvailable() async {
  QueryBuilder<ParseObject> queryVersion =
      QueryBuilder<ParseObject>(ParseObject('AppVersion'));
  final ParseResponse apiResponse = await queryVersion.query();
  if (apiResponse.success && apiResponse.result != null) {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    final currentVersion = int.parse(packageInfo.buildNumber);
    final appVersions = apiResponse.results as List<ParseObject>;
    int lastVersion = -1;
    for (var app in appVersions) {
      if (app["package_name"] as String == packageName) {
        lastVersion = app["version_number"] as int;
        break;
      }
    }
    if (lastVersion > currentVersion) {
      showUpdateDialog();
      print('Show Dialog');
    }
  } else {
    print('error');
  }
}
