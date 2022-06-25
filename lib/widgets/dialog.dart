import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
