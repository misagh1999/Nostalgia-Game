import 'package:flutter/material.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/routes/app_pages.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('گل یا پوچ'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // todo: go to game mode
                  Get.toNamed(Routes.GAME);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue,
                  ),
                  child: Center(
                      child: Text(
                    'شروع بازی',
                    style: TextStyle(color: Colors.white),
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
