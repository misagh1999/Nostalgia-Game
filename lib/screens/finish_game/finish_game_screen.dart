import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:handy_dandy_app/routes/app_pages.dart';
import 'package:handy_dandy_app/widgets/app_bar.dart';

class FinishGameScreen extends StatelessWidget {
  FinishGameScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final isWin = Get.arguments['isWin'] as bool;
    return Scaffold(
      appBar: buildMyAppBar(title: 'پایان'),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width / 4,
                height: Get.width / 4,
                child: SvgPicture.asset(
                  isWin
                      ? "assets/images/happy-face.svg"
                      : "assets/images/sad-face.svg",
                  color: isWin ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                isWin ? 'شما برنده شدید.' : 'شما باختید',
                style: TextStyle(
                    fontFamily: Fonts.Black,
                    fontSize: 20,
                    color: isWin ? Colors.green : Colors.red),
              ),
              Divider(),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  if (homeController.totalScore.value >=
                      homeController.currentTypeScore.value) {
                    Get.back();
                    Get.toNamed(Routes.GAME);
                  } else {
                    Fluttertoast.showToast(msg: 'امتیاز شما مجاز نمی‌باشد');
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: homeController.totalScore.value >=
                              homeController.currentTypeScore.value
                          ? primaryColor
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'بازی مجدد',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: Fonts.Black,
                            fontSize: 20),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      FaIcon(
                        FontAwesomeIcons.rotateLeft,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'خروج',
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: Fonts.Black,
                        fontSize: 20),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
