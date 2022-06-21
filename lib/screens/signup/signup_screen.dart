import 'package:flutter/material.dart';
import 'package:handy_dandy_app/constants.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ثبت نام'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
              child: Column(
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
                height: 12,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'تکرار رمز عبور'),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'نام مستعار'),
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  // go to main
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: primaryColor),
                  child: Center(
                    child: Text(
                      'ثبت نام',
                      style: TextStyle(
                          fontFamily: Fonts.Bold, color: Colors.white),
                    ),
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
