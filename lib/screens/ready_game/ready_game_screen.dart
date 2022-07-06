import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/game_controller.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:handy_dandy_app/utils/utils.dart';
import 'package:handy_dandy_app/widgets/app_bar.dart';

import 'components/score_type_button.dart';

class ReadyGameScreen extends StatelessWidget {
  ReadyGameScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();
  final GameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(title: controller.gameTitle.value),
      body: SafeArea(
        child: Obx(
          () => Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildOfflineOnlineToggle(
                        title: 'آفلاین',
                        isSelected: !controller.isOnlineMode.value,
                        onPress: () {
                          if (!controller.isFinding.value)
                            controller.setOfflineMode();
                        }),
                    SizedBox(
                      width: 16,
                    ),
                    _buildOfflineOnlineToggle(
                        title: 'آنلاین',
                        isSelected: controller.isOnlineMode.value,
                        onPress: () {
                          if (!controller.isFinding.value)
                            controller.setOnlineMode();
                        }),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Spacer(),
                Row(
                  children: [
                    ScoreTypeButton(
                      score: '10',
                      isSelected: homeController.currentTypeIndex.value == 1,
                      isEnabled: !controller.isOnlineMode.value,
                      press: () {
                        if (!controller.isOnlineMode.value)
                          homeController.select10Score();
                      },
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    ScoreTypeButton(
                      score: '25',
                      isSelected: homeController.currentTypeIndex.value == 2,
                      isEnabled: !controller.isOnlineMode.value,
                      press: () {
                        if (!controller.isOnlineMode.value)
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
                TextField(
                  controller: controller.aliasTextController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: 'نام مستعار',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    if (!controller.isFinding.value) controller.onPlayButton();
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: controller.errorPlayGameStr.value.isEmpty
                            ? primaryColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(24)),
                    child: controller.isFinding.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'در حال جستجوی رقیب',
                                style: TextStyle(
                                    fontFamily: Fonts.Bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              SpinKitCircle(
                                color: Colors.white,
                                size: 24,
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'شروع',
                                style: TextStyle(
                                    fontFamily: Fonts.Bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              FaIcon(
                                FontAwesomeIcons.globe,
                                color: Colors.white,
                              ),
                            ],
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOfflineOnlineToggle(
      {required String title,
      required bool isSelected,
      required VoidCallback onPress}) {
    return Expanded(
        child: GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected ? primaryColor : Colors.grey.withOpacity(0.1)),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              fontFamily: Fonts.Bold,
              color: isSelected ? Colors.white : primaryColor),
        )),
      ),
    ));
  }
}
