import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/widgets/app_bar.dart';

import '../../../constants.dart';
import '../../../controllers/home_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/utils.dart';
import '../../ready_game/components/play_button_widget.dart';
import '../../ready_game/components/score_type_button.dart';

class HandRockReadyScreen extends StatelessWidget {
  HandRockReadyScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(title: 'سنگ کاغذ قیچی'),
      body: SafeArea(
        child: Obx(
          () => Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  READY_DESC_HAND_ROCK,
                  textAlign: TextAlign.justify,
                ),
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
                      Get.toNamed(Routes.MAIN_HAND_ROCK);
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
