import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';

import '../../routes/app_pages.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), goToNextScreen);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset(
            'assets/images/logo.png',
            width: Get.width / 3,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'بازی گل یا پوچ',
            style: TextStyle(fontFamily: Fonts.Black, fontSize: 24),
          ),
          Container(
            width: 48,
            height: 48,
            child: SpinKitCircle(
              color: primaryColor,
              size: 48,
            ),
          ),
          Spacer(),
          Text(
            'برنامه‌نویس: محمدحسین میثاق‌پور',
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            'v 1.0.0',
            style: TextStyle(color: Colors.grey),
          )
        ],
      )),
    );
  }

  goToNextScreen() {
    // Get.offAndToNamed(Routes.LOGIN);
    Get.offNamed(Routes.HOME);
  }
}
