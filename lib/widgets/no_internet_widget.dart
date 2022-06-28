import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../constants.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    Key? key,
    required this.onRetry,
    required this.onBack,
  }) : super(key: key);
  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/no-internet.png',
              width: Get.width / 3,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'اتصال اینترنت وجود ندارد',
              style: TextStyle(fontFamily: Fonts.Bold, fontSize: 18),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onBack,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 3, color: primaryColor)),
                      padding: EdgeInsets.all(12),
                      child: Center(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.arrowRight,
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'بازگشت',
                            style: TextStyle(
                                fontFamily: Fonts.Bold,
                                color: primaryColor,
                                fontSize: 16),
                          ),
                        ],
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: onRetry,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: primaryColor),
                      padding: EdgeInsets.all(12),
                      child: Center(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.rotateLeft,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'تلاش مجدد',
                            style: TextStyle(
                                fontFamily: Fonts.Bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ],
                      )),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
