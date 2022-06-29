import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/online_game_controller.dart';
import 'package:handy_dandy_app/utils/utils.dart';
import 'package:handy_dandy_app/widgets/app_bar.dart';
import 'package:get/get.dart';

import '../../../widgets/no_internet_box.dart';

class OnlineReadyGameScreen extends StatelessWidget {
  OnlineReadyGameScreen({Key? key}) : super(key: key);

  final OnlineGameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(title: 'بازی‌ آنلاین'),
      body: SafeArea(
        child: Obx(
          () => Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !controller.hasInternetConnection.value
                    ? NoInternetBox()
                    : Container(
                        child: Container(
                          child: Column(
                            children: [
                              Text('تعداد افراد آنلاین'),
                              Text(
                                replacePersianNum(
                                    controller.totalOnlinePlayers.toString()),
                                style: TextStyle(
                                    fontFamily: Fonts.Bold, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                Divider(),
                Text(
                  READY_DESC_ONLINE,
                  textAlign: TextAlign.justify,
                ),
                Spacer(),
                SvgPicture.asset(
                  'assets/coin.svg',
                  width: 50,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'امتیاز بازی',
                  style: TextStyle(fontFamily: Fonts.Medium, fontSize: 18),
                ),
                Text(
                  '۵۰',
                  style: TextStyle(fontFamily: Fonts.Bold, fontSize: 24),
                ),
                Spacer(
                  flex: 2,
                ),
                TextField(
                  controller: controller.aliasTextController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: 'نام مستعار',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    if (!controller.isFinding.value) controller.requestToJoin();
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: controller.hasInternetConnection.value
                            ? primaryColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(24)),
                    child: controller.isFinding.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'در حال جستجوی رقیب',
                                style: TextStyle(
                                    fontFamily: Fonts.Bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              SpinKitCircle(
                                color: Colors.white,
                                size: 24,
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'اتصال',
                                style: TextStyle(
                                    fontFamily: Fonts.Bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              FaIcon(
                                FontAwesomeIcons.globe,
                                color: Colors.white,
                              ),
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
