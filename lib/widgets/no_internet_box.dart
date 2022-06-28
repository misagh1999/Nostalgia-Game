import 'package:flutter/material.dart';

import '../constants.dart';

class NoInternetBox extends StatelessWidget {
  const NoInternetBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.red)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'اتصال به اینترنت وجود ندارد',
            style: TextStyle(
                fontFamily: Fonts.Medium, color: Colors.red),
          ),
          SizedBox(
            width: 4,
          ),
          Image.asset(
            'assets/images/no-internet.png',
            width: 20,
            height: 20,
          )
        ],
      ),
    );
  }
}