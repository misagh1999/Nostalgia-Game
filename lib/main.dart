import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'theme.dart';

void main() {
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
