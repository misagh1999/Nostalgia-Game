import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';

blinkColor(Rx<Color> color, bool isTrue) async {
  if (isTrue) {
    color.value = Colors.green;
  } else {
    color.value = Colors.red;
  }
  await Future.delayed(Duration(milliseconds: 500));
  color.value = lightGreyColor!;
}
