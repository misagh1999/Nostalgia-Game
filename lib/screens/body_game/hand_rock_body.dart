import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../controllers/hand_rock_controller.dart';

class HandRockBody extends StatelessWidget {
  HandRockBody({
    Key? key,
  }) : super(key: key);

  final HandRockController controller = Get.put(HandRockController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                _buildSelectedOption(
                    title: 'Your Turn',
                    color: controller.yourOptionColor.value,
                    icon: controller.yourOptionIcon.value,
                    isSelecting:
                        controller.yourStatus.value == RivalStatus.isSelecting),
                Spacer(
                  flex: 2,
                ),
                _buildSelectedOption(
                    title: 'Rival Turn',
                    color: controller.rivalOptionColor.value,
                    icon: controller.rivalOptionIcon.value,
                    isSelecting: controller.rivalStatus.value ==
                        RivalStatus.isSelecting),
                Spacer()
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Divider(),
            Text('Please Choose Your Option'),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                _buildOnSelectOptionsWidget(
                    icon: FontAwesomeIcons.hand,
                    isSelected:
                        controller.yourOptionType.value == OptionType.hand,
                    onPress: () {
                      controller.onChooseButton(OptionType.hand);
                    }),
                Spacer(),
                _buildOnSelectOptionsWidget(
                    icon: FontAwesomeIcons.handScissors,
                    isSelected:
                        controller.yourOptionType.value == OptionType.scisors,
                    onPress: () {
                      controller.onChooseButton(OptionType.scisors);
                    }),
                Spacer(),
                _buildOnSelectOptionsWidget(
                    icon: FontAwesomeIcons.handBackFist,
                    isSelected:
                        controller.yourOptionType.value == OptionType.rock,
                    onPress: () {
                      controller.onChooseButton(OptionType.rock);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _buildSelectedOption(
      {required String title,
      required bool isSelecting,
      required Color color,
      required IconData icon}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontFamily: Fonts.Medium),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          width: Get.width / 4,
          height: Get.width / 4,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: primaryColor)),
          child: Center(
              child: isSelecting
                  ? SpinKitCircle(
                      color: primaryColor,
                      size: Get.width / 6,
                    )
                  : FaIcon(
                      icon,
                      size: Get.width / 6,
                    )),
        )
      ],
    );
  }

  Widget _buildOnSelectOptionsWidget(
      {required IconData icon,
      required VoidCallback onPress,
      required bool isSelected}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: Get.width / 4,
        height: Get.width / 4,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            border: controller.yourStatus.value == RivalStatus.isSelecting
                ? null
                : isSelected
                    ? Border.all(width: 3, color: primaryColor)
                    : null,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: FaIcon(
          icon,
          color: controller.yourStatus.value == RivalStatus.isSelecting
              ? Colors.black
              : isSelected
                  ? primaryColor
                  : Colors.grey,
          size: Get.width / 7,
        )),
      ),
    );
  }
}
