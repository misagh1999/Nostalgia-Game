import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بازی اصلی'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
              child: Column(
            children: [
              Row(
                children: [
                  Text('نوبت: '),
                  Text('1'),
                  Spacer(),
                  Text('جان: '),
                  Text('2')
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // todo: select number 1
                      },
                      child: Container(
                        height: Get.width / 2.5,
                        decoration: BoxDecoration(color: Colors.orange),
                        child: Center(
                            child: Text(
                          'جعبه ۱',
                          style:
                              TextStyle(fontFamily: Fonts.Black, fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // todo: select number 2
                      },
                      child: Container(
                        height: Get.width / 2.5,
                        decoration: BoxDecoration(color: Colors.orange),
                        child: Center(
                            child: Text(
                          'جعبه ۲',
                          style:
                              TextStyle(fontFamily: Fonts.Black, fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Text('متاسفانه شما باختید.'),
            ],
          )),
        ),
      ),
    );
  }
}
