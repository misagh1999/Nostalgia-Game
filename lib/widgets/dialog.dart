import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../constants.dart';
import 'my_button.dart';

showMyDialog(
    {required String title,
    required String message,
    String confirmTitle = "بله",
    String cancleTitle = "خیر",
    required VoidCallback onCancel,
    required VoidCallback onConfirm}) {
  Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(color: primaryColor),
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      content: Column(
        children: [
          Text(message),
          SizedBox(
            height: 16,
          ),
          MyButton(title: confirmTitle, press: onConfirm),
          SizedBox(
            height: 8,
          ),
          MyButton(
              title: cancleTitle,
              bgColor: Colors.white,
              titleColor: primaryColor,
              press: onCancel),
        ],
      ));
}

showUpdateDialog() {
  Get.defaultDialog(
      title: 'بروزرسانی نسخه جدید',
      titleStyle: TextStyle(color: primaryColor),
      content: Column(
        children: [
          Text(
            'نسخه جدید اپلیکیشن در دسترس است.',
            style: TextStyle(fontFamily: Fonts.Medium),
          ),
          Divider(),
          SizedBox(
            height: 16,
          ),
          MyButton(
              title: 'دریافت',
              press: () async {
                PackageInfo packageInfo = await PackageInfo.fromPlatform();
                final packageName = packageInfo.packageName;
                Get.back();
                Get.back();
                if (GetPlatform.isAndroid) {
                  AndroidIntent intent = AndroidIntent(
                      action: 'android.intent.action.VIEW',
                      data: Uri.parse("bazaar://details?id=" + packageName)
                          .toString(),
                      package: "com.farsitel.bazaar");
                  intent.launch();
                }
              }),
          SizedBox(
            height: 16,
          ),
          MyButton(
              title: 'بستن',
              bgColor: Colors.white,
              titleColor: primaryColor,
              press: () {
                Get.back();
              }),
        ],
      ));
}

showDisconnectRival({required VoidCallback onBack}) {
  Get.defaultDialog(
      title: 'قطع اتصال حریف',
      titleStyle: TextStyle(color: primaryColor),
      onWillPop: () async {
        onBack();
        return false;
      },
      content: Column(
        children: [
          Text(
            'حریف شما از بازی خارج شد',
            style: TextStyle(fontFamily: Fonts.Medium),
          ),
          SvgPicture.asset(
            'assets/sad-face.svg',
            width: 50,
          ),
          SizedBox(
            height: 12,
          ),
          MyButton(
              title: 'بازگشت',
              bgColor: primaryColor,
              titleColor: Colors.white,
              press: onBack),
        ],
      ));
}
