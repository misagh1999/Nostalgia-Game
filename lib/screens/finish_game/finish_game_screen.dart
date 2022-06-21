import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:handy_dandy_app/routes/app_pages.dart';

import '../../utils/utils.dart';

class FinishGameScreen extends StatelessWidget {
  FinishGameScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final isWin = Get.arguments['isWin'] as bool;
    return Scaffold(
      appBar: AppBar(actions: [
        Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Obx(
            () => Text(
              replacePersianNum(homeController.totalScore.toString()),
            ),
          ),
        ))
      ]),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isWin ? 'شما برنده شدید.' : 'شما باختید',
                style: TextStyle(
                    fontFamily: Fonts.Black,
                    fontSize: 20,
                    color: isWin ? Colors.green : Colors.red),
              ),
              Divider(),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.toNamed(Routes.GAME);
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    'بازی مجدد',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: Fonts.Black,
                        fontSize: 20),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // todo: get of
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'خروج',
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: Fonts.Black,
                        fontSize: 20),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
