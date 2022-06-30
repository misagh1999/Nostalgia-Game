import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../../controllers/online_game_controller.dart';
import '../../../../utils/utils.dart';

class OnlineBoxWidget extends StatelessWidget {
  OnlineBoxWidget({
    Key? key,
    required this.boxNumber,
  }) : super(key: key);
  final int boxNumber;

  final OnlineGameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (controller.canSelect.value || controller.canGuess.value) {
            controller.onClickBox(boxNumber);
          }
        },
        child: Container(
          height: Get.width / 2.5,
          decoration: BoxDecoration(
              color: controller.canSelect.value || controller.canGuess.value
                  ? secondaryColor
                  : Colors.grey,
              borderRadius: BorderRadius.circular(24)),
          child: Center(
              child: Text(
            replacePersianNum('جعبه ' + boxNumber.toString()),
            style: TextStyle(fontFamily: Fonts.Black, fontSize: 20),
          )),
        ),
      ),
    );
  }
}