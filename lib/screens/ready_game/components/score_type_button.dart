import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import 'package:get/get.dart';

class ScoreTypeButton extends StatelessWidget {
  const ScoreTypeButton(
      {Key? key,
      required this.score,
      required this.press,
      this.isEnabled = true,
      required this.isSelected})
      : super(key: key);

  final VoidCallback press;
  final bool isSelected;
  final String score;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: Get.width / 4,
        height: Get.width / 4,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border:
                isSelected ? Border.all(width: 3, color: primaryColor) : null,
            color: Colors.grey.withOpacity(0.1)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 30,
                height: 30,
                child: isEnabled
                    ? SvgPicture.asset(
                        'assets/coin.svg',
                      )
                    : Opacity(
                        opacity: 0.4,
                        child: SvgPicture.asset(
                          'assets/coin.svg',
                        ),
                      )),
            Text(
              score,
              style: TextStyle(
                  fontFamily: Fonts.Bold,
                  fontSize: 24,
                  color: isEnabled ? Colors.black : Colors.grey),
            ),
          ],
        )),
      ),
    ));
  }
}
