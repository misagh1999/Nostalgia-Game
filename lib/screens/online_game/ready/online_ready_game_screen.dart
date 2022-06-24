import 'package:flutter/material.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/online_game_controller.dart';
import 'package:handy_dandy_app/widgets/app_bar.dart';
import 'package:get/get.dart';

class OnlineReadyGameScreen extends StatelessWidget {
  OnlineReadyGameScreen({Key? key}) : super(key: key);

  final OnlineGameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(title: 'بازی‌ آنلاین'),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller.aliasTextController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'نام خود را وارد کنید',
                ),
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  // todo:
                  controller.requestToJoin();
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(24)),
                  child: Text(
                    'اتصال',
                    style: TextStyle(
                        fontFamily: Fonts.Bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
