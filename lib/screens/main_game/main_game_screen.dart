import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/game_controller.dart';
import 'package:handy_dandy_app/screens/body_game/fill_empty_body.dart';
import 'package:handy_dandy_app/screens/body_game/hand_rock_body.dart';

import '../../constants.dart';
import '../../utils/utils.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/rest_live_widget.dart';

class MainGameScreen extends StatelessWidget {
  MainGameScreen({Key? key}) : super(key: key);

  final GameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(title: controller.gameTitle.value),
      body: WillPopScope(
        onWillPop: () {
          return controller.onWillPop();
        },
        child: SafeArea(
          child: Obx(
            () => Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('نوبت باقی مانده'),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        replacePersianNum(controller.restTurn.toString()),
                        style: TextStyle(fontFamily: Fonts.Bold, fontSize: 18),
                      ),
                      Spacer(),
                      Text('امتیاز بازی'),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        replacePersianNum(controller
                            .homeController.currentTypeScore
                            .toString()),
                        style: TextStyle(fontFamily: Fonts.Bold, fontSize: 18),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      _buildPlayerStatus(
                          alias: controller.yourAlias.value,
                          live: controller.yourLive.value,
                          color: controller.yourColor.value,
                          isTurn: controller.isYourTurn.value),
                      SizedBox(
                        width: 20,
                      ),
                      _buildPlayerStatus(
                          alias: controller.rivalAlias.value,
                          live: controller.rivalLive.value,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          color: controller.rivalColor.value,
                          isTurn: controller.isRivalTurn.value),
                    ],
                  ),
                  Spacer(),
                  controller.myGameType == MyGameType.fillEmpty
                      ? FillEmptyBody()
                      : controller.myGameType == MyGameType.handRock
                          ? HandRockBody()
                          : SizedBox(),
                  Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildPlayerStatus(
      {required String alias,
      required int live,
      required Color color,
      CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
      required isTurn}) {
    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: color,
            border: isTurn ? Border.all(width: 2, color: primaryColor) : null,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [Text(alias), RestLiveWidget(restLive: live)],
        ),
      ),
    );
  }
}
