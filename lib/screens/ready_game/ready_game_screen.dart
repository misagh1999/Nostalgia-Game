import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/game_controller.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
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
                Divider(),
                Text(
                  'Game Score',
                  style: TextStyle(
                      fontFamily: Fonts.Bold, fontSize: 18, color: Colors.grey),
                ),
                Text(
                  homeController.currentTypeScore.toString(),
                  style: TextStyle(fontFamily: Fonts.Black, fontSize: 28),
                ),
                Spacer(),
                TextField(
                  onTap: () {
                    if (controller.aliasTextController.selection ==
                        TextSelection.fromPosition(TextPosition(
                            offset: controller.aliasTextController.text.length -
                                1))) {
                      controller.aliasTextController.selection =
                          TextSelection.fromPosition(TextPosition(
                              offset:
                                  controller.aliasTextController.text.length));
                    }
                  },
                  controller: controller.aliasTextController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: 'Your Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 12,
                ),
                _buildPlayButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    return Container(
      decoration: BoxDecoration(
          color: controller.errorPlayGameStr.value.isEmpty
              ? primaryColor
              : Colors.grey,
          borderRadius: BorderRadius.circular(24)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (!controller.isFinding.value) controller.onPlayButton();
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: EdgeInsets.all(16),
            child: controller.isFinding.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'is searching Rival',
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
                        'Play',
                        style: TextStyle(
                            fontFamily: Fonts.Bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      FaIcon(
                        FontAwesomeIcons.play,
                        color: Colors.white,
                      ),
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
        child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? primaryColor : Colors.grey.withOpacity(0.1)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPress,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.all(12),
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                  fontFamily: Fonts.Bold,
                  color: isSelected ? Colors.white : primaryColor),
            )),
          ),
        ),
      ),
    ));
  }
}
