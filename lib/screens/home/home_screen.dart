import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
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
                HomeButtonWidget(
                  title: 'شروع بازی',
                  icon: FontAwesomeIcons.solidCirclePlay,
                  color: primaryColor,
                  press: () {
                    Get.toNamed(Routes.READY_GAME);
                  },
                ),
                SizedBox(height: 12),
                HomeButtonWidget(
                  title: 'بازی آنلاین',
                  icon: FontAwesomeIcons.solidCirclePlay,
                  color: secondaryColor,
                  press: () {
                    Get.toNamed(Routes.READY_ONLINE_GAME);
                  },
                ),
                // todo: remove it later
                // ElevatedButton(
                //     onPressed: () {
                //       controller.addScore();
                //     },
                //     child: Text('test score'))
              ],
            )),
          ),
        ),
      ),
    );
  }
}
