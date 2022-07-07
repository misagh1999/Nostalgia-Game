import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controllers/fill_empty_controller.dart';
import '../../../utils/utils.dart';

class FillEmptyBoxWidget extends StatelessWidget {
  FillEmptyBoxWidget({
    Key? key,
    required this.boxNumber,
  }) : super(key: key);
  final int boxNumber;

  final FillEmptyController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          if (controller.canSelect.value || controller.canGuess.value) {
            controller.onClickBox(boxNumber);
          }
        },
        child: Container(
          height: Get.width / 2.75,
          width: Get.width / 2.75,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(24)),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.box,
                  size: Get.width / 4,
                  color: boxNumber == 1
                      ? controller.box1Color.value
                      : controller.box2Color.value),
              Text(
                replacePersianNum('جعبه ' + boxNumber.toString()),
                style: TextStyle(
                    fontFamily: Fonts.Black,
                    fontSize: 20,
                    color: boxNumber == 1
                        ? controller.box1Color.value
                        : controller.box2Color.value),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
