import 'package:flutter/material.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/online_game_controller.dart';
import 'package:handy_dandy_app/widgets/app_bar.dart';
import 'package:get/get.dart';

class OnlineMainGameScreen extends StatelessWidget {
  OnlineMainGameScreen({Key? key}) : super(key: key);

  final OnlineGameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(title: 'بازی آنلاین'),
      body: SafeArea(
        child: Obx(
          () => Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text('نوبت باقی مانده'),
                Text(
                  controller.restTurn.toString(),
                  style: TextStyle(fontFamily: Fonts.Bold),
                ),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: controller.yourColor.value,
                          border: controller.isYourTurn.value
                              ? Border.all(width: 2, color: primaryColor)
                              : null,
                          borderRadius: BorderRadius.circular(20)),
                      
                      child: Row(
                        children: [
                          Text(controller.yourAlias.value),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            controller.yourLive.toString(),
                            style: TextStyle(fontFamily: Fonts.Bold),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: controller.isYourTurn.value
                              ? null
                              : Border.all(width: 2, color: primaryColor),
                          color: controller.rivalColor.value,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Text(
                            controller.rivalLive.toString(),
                            style: TextStyle(fontFamily: Fonts.Bold),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(controller.rivalAlias.value),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(controller.messageTitle.value),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (controller.canSelect.value ||
                              controller.canGuess.value) {
                            // todo
                            controller.onClickBox(1);
                          }
                        },
                        child: Container(
                          height: Get.width / 2.5,
                          decoration: BoxDecoration(
                              color: controller.canSelect.value ||
                                      controller.canGuess.value
                                  ? secondaryColor
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(24)),
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
                          // todo:
                          if (controller.canSelect.value ||
                              controller.canGuess.value) {
                            // todo:
                            controller.onClickBox(2);
                          }
                        },
                        child: Container(
                          height: Get.width / 2.5,
                          decoration: BoxDecoration(
                              color: controller.canSelect.value ||
                                      controller.canGuess.value
                                  ? secondaryColor
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(24)),
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
                // SizedBox(height: 12,),
                // Text(controller.resultMessage.value)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
