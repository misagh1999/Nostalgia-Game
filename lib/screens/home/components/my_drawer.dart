import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
                          'بازی گل یا پوچ',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: Fonts.Black,
                              fontSize: 18),
                        ),
                        Text(
                          'By: MohammadHossein Misaghpour',
                          style: TextStyle(
                              fontFamily: Fonts.Medium,
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          Assets.LOGO,
                        )),
                  ],
                ),
                Spacer(),
                FutureBuilder(
                    future: getVersionNumber(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text("v " + (snapshot.data as String),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                            ));
                      } else {
                        return SizedBox();
                      }
                    }),
              ],
            )),
        ListTile(
          leading: Icon(Icons.rate_review),
          title: Text('امتیاز به برنامه'),
          onTap: () async {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            final packageName = packageInfo.packageName;
            Get.back();
            if (GetPlatform.isAndroid) {
              AndroidIntent intent = AndroidIntent(
                  action: 'android.intent.action.EDIT',
                  data: Uri.parse("bazaar://details?id=" + packageName)
                      .toString(),
                  package: "com.farsitel.bazaar");
              intent.launch();
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.apps),
          title: Text('دیگر برنامه‌ها'),
          onTap: () {
            const DEVELOPER_ID = "245778194412";
            Get.back();
            if (GetPlatform.isAndroid) {
              AndroidIntent intent = AndroidIntent(
                  action: 'android.intent.action.VIEW',
                  data: Uri.parse("bazaar://collection?slug=by_author&aid=" +
                          DEVELOPER_ID)
                      .toString(),
                  package: "com.farsitel.bazaar");
              intent.launch();
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('درباره ما'),
          onTap: () {
            Get.back();
            Get.defaultDialog(
                title: "درباره ما",
                middleText: "برنامه‌نویس: محمدحسین میثاق‌پور" +
                    "\n" +
                    "misagh1999@gmail.com",
                textCancel: "بستن",
                cancelTextColor: primaryColor);
          },
        ),
      ],
    ),
  );
}
