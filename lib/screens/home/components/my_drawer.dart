import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/widgets/dialog.dart';

import '../../../constants.dart';
import '../../../utils/utils.dart';

Drawer buildMyDrawer() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            decoration: BoxDecoration(color: primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'نوستالژی پلی',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: Fonts.Black,
                              fontSize: 18),
                        ),
                        Text(
                          'بازی‌های نوستالژی',
                          style: TextStyle(
                              fontFamily: Fonts.Medium,
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset('assets/images/logo_white.png'),
                    ),
                  ],
                ),
                Spacer(),
                FutureBuilder(
                    future: getVersionNumber(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                            replacePersianNum(
                                "نسخه " + (snapshot.data as String)),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                            ));
                      } else {
                        return SizedBox();
                      }
                    }),
              ],
            )),
        _buildNavMenuItem(
            title: 'درباره ما',
            icon: FontAwesomeIcons.user,
            press: () {
              Get.back();
              Get.defaultDialog(
                  title: "درباره ما",
                  middleText: "برنامه‌نویس: محمدحسین میثاق‌پور" +
                      "\n" +
                      "misagh1999@gmail.com",
                  textCancel: "بستن",
                  cancelTextColor: primaryColor);
            }),
      ],
    ),
  );
}

Widget _buildNavMenuItem(
    {required String title,
    required IconData icon,
    required VoidCallback press}) {
  return InkWell(
    onTap: press,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          FaIcon(
            icon,
            color: Colors.grey,
            size: 20,
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: TextStyle(fontFamily: Fonts.Medium),
          )
        ],
      ),
    ),
  );
}
