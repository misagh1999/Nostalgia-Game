import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    Key? key,
    required this.title,
    required this.color,
    required this.press,
  }) : super(key: key);
  final String title;
  final Color color;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: press,
        child: Container(
          height: Get.width / 2.5,
          decoration: BoxDecoration(
              color: this.color, borderRadius: BorderRadius.circular(24)),
          child: Center(
              child: Text(
            title,
            style: TextStyle(fontFamily: Fonts.Black, fontSize: 20),
          )),
        ),
      ),
    );
  }
}
