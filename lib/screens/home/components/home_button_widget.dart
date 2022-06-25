import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class HomeButtonWidget extends StatelessWidget {
  HomeButtonWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.press,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final color;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: Get.width / 2.5,
        height: Get.width / 2.5,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: this.color,
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white, fontFamily: Fonts.Bold, fontSize: 24),
            ),
          ],
        )),
      ),
    );
  }
}
