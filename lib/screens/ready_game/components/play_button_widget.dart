import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class PlayButtonWidget extends StatelessWidget {
  const PlayButtonWidget({Key? key, required this.press, this.isEnabled = true})
      : super(key: key);
  final VoidCallback press;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: Get.width / 3,
        height: Get.width / 3,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: this.isEnabled ? primaryColor : Colors.grey,
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
                  fontFamily: Fonts.Bold, color: Colors.white, fontSize: 20),
            ),
          ],
        )),
      ),
    );
  }
}
