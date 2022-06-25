import 'package:flutter/material.dart';

import '../constants.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
      required this.title,
      required this.press,
      this.gradient,
      this.titleColor,
      this.bgColor})
      : super(key: key);

  final VoidCallback press;
  final String title;
  final gradient;
  final titleColor;
  final bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: this.bgColor != null
              ? LinearGradient(colors: [bgColor, bgColor],)
              : this.gradient != null
                  ? this.gradient
                  : primaryGradint),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: press,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                  color:
                      this.titleColor != null ? this.titleColor : Colors.white,
                  fontFamily: Fonts.Black,
                  fontSize: 18),
            )),
          ),
        ),
      ),
    );
  }
}
