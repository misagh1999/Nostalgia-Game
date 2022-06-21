import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/game_controller.dart';
import 'package:handy_dandy_app/utils/utils.dart';


import '../../controllers/home_controller.dart';

class GameScreen extends StatelessWidget {
  GameScreen({Key? key}) : super(key: key);

  final GameController controller = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'بازی اصلی',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Obx(
              () => Text(
                replacePersianNum(homeController.totalScore.toString()),
              ),
            ),
          ))
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () => Container(
            padding: EdgeInsets.all(16),
            child: Center(
                child: Column(
              children: [
                Row(
                  children: [
                    Text('نوبت باقی مانده: '),
                    Obx(() => Text(
                          replacePersianNum(
                              controller.restTurn.value.toString()),
                          style:
                              TextStyle(fontFamily: Fonts.Bold, fontSize: 18),
                        )),
                    Spacer(),
                    Text('جان: '),
                    Text(
                      replacePersianNum(controller.live.value.toString()),
                      style: TextStyle(fontFamily: Fonts.Bold, fontSize: 20),
                    )
                  ],
                ),
                Spacer(),
                Container(
                  height: 50,
                  child: controller.isSelectState.value
                      ? Text(
                          'یک جعبه را انتخاب کنید',
                          style:
                              TextStyle(fontFamily: Fonts.Medium, fontSize: 18),
                        )
                      : SizedBox(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (controller.isSelectState.value)
                            controller.onSelectBox1();
                        },
                        child: Container(
                          height: Get.width / 2.5,
                          decoration: BoxDecoration(
                              color: controller.boxColor1.value,
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                              child: Text(
                            'جعبه ۱',
                            style: TextStyle(
                                fontFamily: Fonts.Black, fontSize: 20),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (controller.isSelectState.value)
                            controller.onSelectBox2();
                        },
                        child: Container(
                          height: Get.width / 2.5,
                          decoration: BoxDecoration(
                              color: controller.boxColor2.value,
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                              child: Text(
                            'جعبه ۲',
                            style: TextStyle(
                                fontFamily: Fonts.Black, fontSize: 20),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 100,
                  child: controller.isSelectState.value
                      ? SizedBox()
                      : Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.nextTurn();
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Text(
                                  'نوبت بعد',
                                  style: TextStyle(
                                      fontFamily: Fonts.Bold,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                ),
                Spacer()
              ],
            )),
          ),
        ),
      ),
    );
  }
}
