import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class HomeButtonWidget extends StatelessWidget {
  HomeButtonWidget({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.press,
  }) : super(key: key);
  final String title;
  final VoidCallback press;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        border: Border.all(width: 3, color: primaryColor),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: Get.width / 2.5,
            height: Get.width / 2.5,
            padding: EdgeInsets.all(8),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 56,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: Fonts.Bold,
                      fontSize: 17),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
