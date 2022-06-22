import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../utils/utils.dart';
import 'package:get/get.dart';

class ScoreTypeButton extends StatelessWidget {
  const ScoreTypeButton(
      {Key? key,
      required this.score,
      required this.press,
      required this.isSelected})
      : super(key: key);

  final VoidCallback press;
  final bool isSelected;
  final String score;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: press,
      child: Container(
        width: Get.width / 4,
        height: Get.width / 4,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              width: isSelected ? 3 : 0,
            ),
            color: Colors.grey.withOpacity(0.1)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 30,
                height: 30,
                child: SvgPicture.asset('assets/coin.svg')),
            Text(
              replacePersianNum(score),
              style: TextStyle(fontFamily: Fonts.Bold, fontSize: 24),
            ),
          ],
        )),
      ),
    ));
  }
}
