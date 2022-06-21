import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/game_controller.dart';

class GameScreen extends StatelessWidget {
  GameScreen({Key? key}) : super(key: key);

  final GameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بازی اصلی'),
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
                    Obx(() => Text(controller.restTurn.value.toString())),
                    Spacer(),
                    Text('جان: '),
                    Text(controller.live.value.toString())
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                controller.isSelectState.value
                    ? Text('یک جعبه را انتخاب کنید')
                    : SizedBox(),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // todo: select number 1
                          if (controller.isSelectState.value)
                            controller.onSelectBox1();
                        },
                        child: Container(
                          height: Get.width / 2.5,
                          decoration:
                              BoxDecoration(color: controller.boxColor1.value),
                          child: Center(
                              child: Text(
                            'جعبه ۱',
                            style: TextStyle(
                                fontFamily: Fonts.Black, fontSize: 18),
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
                          // todo: select number 2
                          if (controller.isSelectState.value)
                            controller.onSelectBox2();
                        },
                        child: Container(
                          height: Get.width / 2.5,
                          decoration:
                              BoxDecoration(color: controller.boxColor2.value),
                          child: Center(
                              child: Text(
                            'جعبه ۲',
                            style: TextStyle(
                                fontFamily: Fonts.Black, fontSize: 18),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                controller.isSelectState.value
                    ? SizedBox()
                    : Text(
                        controller.message.value,
                        style: TextStyle(
                            fontFamily: Fonts.Bold,
                            color: controller.isTrue.value
                                ? Colors.green
                                : Colors.red),
                      ),
                SizedBox(
                  height: 12,
                ),
                controller.isSelectState.value
                    ? SizedBox()
                    : GestureDetector(
                        onTap: () {
                          controller.nextTurn();
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Text('نوبت بعد'),
                        ),
                      )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
