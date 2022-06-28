import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RestLiveWidget extends StatelessWidget {
  RestLiveWidget({
    Key? key,
    required this.restLive,
  }) : super(key: key);
  final int restLive;

  @override
  Widget build(BuildContext context) {
    double size = 20;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        restLive >= 3
            ? SvgPicture.asset(
                'assets/heart.svg',
                width: size,
                height: size,
              )
            : SizedBox(),
        SizedBox(
          width: 2,
        ),
        restLive >= 2
            ? SvgPicture.asset(
                'assets/heart.svg',
                width: size,
                height: size,
              )
            : SizedBox(),
        SizedBox(
          width: 2,
        ),
        restLive >= 1
            ? SvgPicture.asset(
                'assets/heart.svg',
                width: size,
                height: size,
              )
            : SizedBox(),
      ],
    );
  }
}
