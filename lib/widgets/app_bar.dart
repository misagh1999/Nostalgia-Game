import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/home_controller.dart';
import '../utils/utils.dart';

AppBar buildMyAppBar({required String title}) {
  final HomeController controller = Get.find();
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontSize: 16),
    ),
    foregroundColor: Colors.black,
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Obx(
              () => Text(
                replacePersianNum(
                  controller.totalScore.toString(),
                ),
                style: TextStyle(fontFamily: Fonts.Medium),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Container(
                width: 20,
                height: 20,
                child: SvgPicture.asset(
                  "assets/coin.svg",
                )),
          ],
        ),
      ))
    ],
    centerTitle: true,
  );
}
