import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/game_controller.dart';
import 'package:handy_dandy_app/utils/utils.dart';
import 'package:handy_dandy_app/widgets/app_bar.dart';

import '../../controllers/home_controller.dart';
import '../../widgets/rest_live_widget.dart';
import 'components/box_widget.dart';

class GameScreen extends StatelessWidget {
  GameScreen({Key? key}) : super(key: key);

  final GameController controller = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(title: 'بازی اصلی'),
      body: WillPopScope(
        onWillPop: () async {
          return controller.onWillPop();
        },
        child: SafeArea(
          child: Obx(
            () => Container(
              padding: EdgeInsets.all(16),
              child: Center(
                  child: Column(
                children: [
                  Text(
                    'امتیاز',
                    style:
                        TextStyle(fontFamily: Fonts.Medium, color: Colors.grey),
                  ),
                  Text(
                    replacePersianNum(
                        homeController.currentTypeScore.toString()),
                    style: TextStyle(fontFamily: Fonts.Black, fontSize: 20),
                  ),
                  Row(
                    children: [
                      Text(
                        'نوبت باقی مانده: ',
                        style: TextStyle(
                            fontFamily: Fonts.Medium, color: Colors.grey),
                      ),
                      Obx(() => Text(
                            replacePersianNum(
                                controller.restTurn.value.toString()),
                            style:
                                TextStyle(fontFamily: Fonts.Bold, fontSize: 20),
                          )),
                      Spacer(),
                      RestLiveWidget(
                        restLive: controller.live.value,
                      )
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    child: controller.isSelectState.value
                        ? Text(
                            'یک جعبه را انتخاب کنید',
                            style: TextStyle(
                                fontFamily: Fonts.Medium, fontSize: 18),
                          )
                        : SizedBox(),
                  ),
                  Row(
                    children: [
                      BoxWidget(
                        title: 'جعبه ۱',
                        color: controller.boxColor1.value,
                        press: () {
                          if (controller.isSelectState.value)
                            controller.onSelectBox1();
                        },
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      BoxWidget(
                        title: 'جعبه ۲',
                        color: controller.boxColor2.value,
                        press: () {
                          if (controller.isSelectState.value)
                            controller.onSelectBox2();
                        },
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
      ),
    );
  }
}
