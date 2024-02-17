import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/game_controller.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:handy_dandy_app/routes/app_pages.dart';

import '../../widgets/app_bar.dart';
import 'components/home_button_widget.dart';
import 'components/my_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(title: 'Nostalgia Game'),
      drawer: buildMyDrawer(),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text(
            'Please Press Back Button Again to Exit',
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
                      title: 'Guess Box',
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
                      title: 'Rock Paper Scissors',
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
                      title: 'Tic Tac Toe',
                      imagePath: 'assets/images/tick_tok_took.png',
                      press: () {
                        if (!Get.isSnackbarOpen)
                          Get.snackbar('Tic Tac Toe Game',
                              'This game will be availble in next updates',
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
                      title: 'Dot Game',
                      imagePath: 'assets/images/dote_game.png',
                      press: () {
                        if (!Get.isSnackbarOpen)
                          Get.snackbar('Dot Game',
                              'This game will be availble in next updates',
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
                          'Daily Lottery',
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
