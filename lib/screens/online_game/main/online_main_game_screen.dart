import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/online_game_controller.dart';
import 'package:handy_dandy_app/utils/utils.dart';
import 'package:handy_dandy_app/widgets/app_bar.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/widgets/rest_live_widget.dart';

class OnlineMainGameScreen extends StatelessWidget {
  OnlineMainGameScreen({Key? key}) : super(key: key);

  final OnlineGameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(title: 'بازی آنلاین'),
      body: WillPopScope(
        onWillPop: () {
          return controller.onWillPop();
        },
        child: SafeArea(
          child: Obx(
            () => Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('نوبت باقی مانده'),
                  Text(
                    replacePersianNum(controller.restTurn.toString()),
                    style: TextStyle(fontFamily: Fonts.Bold, fontSize: 18),
                  ),
                  SizedBox(height: 12,),
                  Row(
                    children: [
                      Expanded(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: controller.yourColor.value,
                              border: controller.isYourTurn.value
                                  ? Border.all(width: 2, color: primaryColor)
                                  : null,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(controller.yourAlias.value),
                              RestLiveWidget(
                                  restLive: controller.yourLive.value)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: controller.isYourTurn.value
                                  ? null
                                  : Border.all(width: 2, color: primaryColor),
                              color: controller.rivalColor.value,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                controller.rivalAlias.toString(),
                              ),
                              RestLiveWidget(
                                  restLive: controller.rivalLive.value)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        controller.messageTitle.value,
                        style: TextStyle(fontFamily: Fonts.Medium),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      controller.isSelectingRival.value
                          ? SpinKitCircle(
                              color: primaryColor,
                              size: 20,
                            )
                          : SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: 16,
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
                            if (controller.canSelect.value ||
                                controller.canGuess.value) {
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
                  Spacer(
                    flex: 2,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
