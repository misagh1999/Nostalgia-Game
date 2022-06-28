import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:handy_dandy_app/routes/app_pages.dart';
import 'package:handy_dandy_app/utils/utils.dart';
import 'package:handy_dandy_app/widgets/app_bar.dart';

import 'components/play_button_widget.dart';
import 'components/score_type_button.dart';

class ReadyGameScreen extends StatelessWidget {
  ReadyGameScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(title: 'توضیحات بازی'),
      body: SafeArea(
        child: Obx(
          () => Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(READY_DESC, textAlign: TextAlign.justify,),
                SizedBox(
                  height: 36,
                ),
                Spacer(),
                Row(
                  children: [
                    ScoreTypeButton(
                      score: '10',
                      isSelected: homeController.currentTypeIndex.value == 1,
                      press: () {
                        homeController.select10Score();
                      },
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    ScoreTypeButton(
                      score: '25',
                      isSelected: homeController.currentTypeIndex.value == 2,
                      press: () {
                        homeController.select25Score();
                      },
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    ScoreTypeButton(
                      score: '50',
                      isSelected: homeController.currentTypeIndex.value == 3,
                      press: () {
                        homeController.select50Score();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'امتیاز این بازی',
                  style: TextStyle(
                      fontFamily: Fonts.Bold, fontSize: 18, color: Colors.grey),
                ),
                Text(
                  replacePersianNum(homeController.currentTypeScore.toString()),
                  style: TextStyle(fontFamily: Fonts.Black, fontSize: 28),
                ),
                Spacer(),
                PlayButtonWidget(
                  press: () {
                    if (homeController.totalScore.value >=
                        homeController.currentTypeScore.value) {
                      Get.toNamed(Routes.GAME);
                    } else {
                      Fluttertoast.showToast(msg: 'امتیاز شما مجاز نمی‌باشد');
                    }
                  },
                  isEnabled: homeController.totalScore.value >=
                      homeController.currentTypeScore.value,
                ),
                Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
