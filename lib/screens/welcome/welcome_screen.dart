import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';

import '../../routes/app_pages.dart';
import '../../utils/utils.dart';

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
            'assets/images/logo_dark.png',
            width: Get.width / 3,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'نوستالیژی پلی',
            style: TextStyle(fontFamily: Fonts.Black, fontSize: 24),
          ),
          Text(
            'بازی‌های نوستالیژی آنلاین',
            style: TextStyle(fontFamily: Fonts.Bold, fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 16,),
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
          FutureBuilder(
              future: getVersionNumber(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("نسخه " + (snapshot.data as String),
                      style: TextStyle(
                        color: Colors.grey,
                      ));
                } else {
                  return SizedBox();
                }
              }),
        ],
      )),
    );
  }

  goToNextScreen() {
    Get.offNamed(Routes.HOME);
  }
}
