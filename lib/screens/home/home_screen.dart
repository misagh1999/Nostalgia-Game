import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:handy_dandy_app/routes/app_pages.dart';

import '../../widgets/app_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(title: 'گل یا پوچ'),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.READY_GAME);
                },
                child: Container(
                  width: Get.width / 2.25,
                  height: Get.width / 2.25,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryColor,
                  ),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidCirclePlay,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'شروع بازی',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: Fonts.Bold,
                            fontSize: 24),
                      ),
                    ],
                  )),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
