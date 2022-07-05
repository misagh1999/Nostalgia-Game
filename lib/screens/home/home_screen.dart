import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/game_controller.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:handy_dandy_app/routes/app_pages.dart';
import 'package:handy_dandy_app/utils/utils.dart';

import '../../widgets/app_bar.dart';
import 'components/home_button_widget.dart';
import 'components/my_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    showUpdateDialogIfAvailable();
    return Scaffold(
      appBar: buildMyAppBar(title: 'گل یا پوچ'),
      drawer: buildMyDrawer(),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text(
            'برای خروج دوباره دکمه بازگشت را بفشارید',
            style: TextStyle(fontFamily: Fonts.Regular),
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    HomeButtonWidget(
                      title: 'گل یا پوچ',
                      icon: FontAwesomeIcons.solidCirclePlay,
                      color: primaryColor,
                      press: () {
                        Get.toNamed(Routes.READY_GAME,
                            arguments: {'game': MyGameType.fillEmpty});
                      },
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    HomeButtonWidget(
                      title: 'سنگ کاغذ قیچی',
                      icon: FontAwesomeIcons.handFist,
                      color: primaryColor,
                      press: () {
                        Get.toNamed(Routes.READY_GAME,
                            arguments: {'game': MyGameType.handRock});
                      },
                    ),
                    Spacer(),
                  ],
                ),

                SizedBox(height: 12),
                // todo:  ignored temp
                HomeButtonWidget(
                  title: 'بازی آنلاین',
                  icon: FontAwesomeIcons.solidCirclePlay,
                  color: secondaryColor,
                  press: () {
                    controller.analytics
                        .setCurrentScreen(screenName: 'Online Game');
                    Get.toNamed(Routes.READY_ONLINE_GAME);
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.DAILY_LOTTERY);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 3, color: primaryColor)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('قرعه کشی روزانه'),
                        SizedBox(
                          width: 4,
                        ),
                        SvgPicture.asset(
                          'assets/lottery.svg',
                          width: 36,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
