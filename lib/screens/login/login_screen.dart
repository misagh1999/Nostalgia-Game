import 'package:flutter/material.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/routes/app_pages.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ورود'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'نام کاربری'),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'رمز عبور'),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    // go to main
                    // todo: change it later
                    Get.toNamed(Routes.HOME);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(color: primaryColor),
                    child: Center(
                      child: Text(
                        'ورود',
                        style: TextStyle(
                            fontFamily: Fonts.Bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text('آیا حساب کاربری ندارید؟'),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.SIGNUP);
                    },
                    child: Container(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'ثبت نام',
                          style: TextStyle(
                              fontFamily: Fonts.Black, color: primaryColor),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
