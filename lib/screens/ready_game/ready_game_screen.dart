import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:handy_dandy_app/routes/app_pages.dart';
import 'package:handy_dandy_app/utils/utils.dart';
import 'package:handy_dandy_app/widgets/app_bar.dart';

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
                Text(READY_DESC),
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
                GestureDetector(
                  onTap: () {
                    Get.offNamed(Routes.GAME);
                  },
                  child: Container(
                    width: Get.width / 3,
                    height: Get.width / 3,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(24)),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.solidCirclePlay,
                          color: Colors.white,
                          size: 36,
                        ),
                        Text(
                          'شروع',
                          style: TextStyle(
                              fontFamily: Fonts.Bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ],
                    )),
                  ),
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
