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
    return Scaffold(
      appBar: buildMyAppBar(title: 'نوستالژی پلی'),
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
                Spacer(
                  flex: 2,
                ),
                Row(
                  children: [
                    Spacer(),
                    HomeButtonWidget(
                      title: 'گل یا پوچ',
                      imagePath: 'assets/images/fill_empty.png',
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
                      imagePath: 'assets/images/scissors.png',
                      press: () {
                        Get.toNamed(Routes.READY_GAME,
                            arguments: {'game': MyGameType.handRock});
                      },
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Spacer(),
                    HomeButtonWidget(
                      title: 'دوز',
                      imagePath: 'assets/images/tick_tok_took.png',
                      press: () {
                        if (!Get.isSnackbarOpen)
                          Get.snackbar('بازی دوز',
                              'این بازی در آپدیت‌های جدید ارائه می‌شود.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              padding: EdgeInsets.all(16));
                      },
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    HomeButtonWidget(
                      title: 'نقطه بازی',
                      imagePath: 'assets/images/dote_game.png',
                      press: () {
                        if (!Get.isSnackbarOpen)
                          Get.snackbar('بازی نقطه بازی',
                              'این بازی در آپدیت‌های جدید ارائه می‌شود.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              padding: EdgeInsets.all(16));
                      },
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(
                  flex: 2,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.DAILY_LOTTERY);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 2, color: primaryColor)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/lottery.svg',
                          width: 48,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'قرعه کشی روزانه',
                          style:
                              TextStyle(fontFamily: Fonts.Bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer()
              ],
            )),
          ),
        ),
      ),
    );
  }
}
