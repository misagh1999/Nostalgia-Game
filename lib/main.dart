import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'routes/app_pages.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final keyApplicationId = 'BbTz690vBoxXF2FlyMh3V8NAARsL6i4xEsRfM4eU';
  final keyClientKey = 'sFVDMKqfsPxK4wqFFlfHetlFY7Gf5jtrWpnlmSxD';
  final keyParseServerUrl = 'https://parseapi.back4app.com';
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: false);
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'گل یا پوچ',
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: [Locale("en", "US"), Locale("fa", "IR")],
      theme: lightThemeData(context),
      locale: Locale("fa", "IR"),
      initialRoute: Routes.WELCOME,
      getPages: AppPages.pages,
      defaultTransition: Transition.fade,
    );
  }
}
