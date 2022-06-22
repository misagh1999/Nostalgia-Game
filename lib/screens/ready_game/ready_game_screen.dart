import 'package:flutter/material.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:handy_dandy_app/routes/app_pages.dart';
import 'package:handy_dandy_app/utils/utils.dart';
import 'package:handy_dandy_app/widgets/app_bar.dart';

class ReadyGameScreen extends StatelessWidget {
  ReadyGameScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(title: 'توضیحات بازی'),
      body: SafeArea(
        child: Obx(
          () => Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(READY_DESC),
                SizedBox(
                  height: 36,
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        homeController.select10Score();
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              width: homeController.currentTypeIndex.value == 1
                                  ? 3
                                  : 0,
                            ),
                            color: primaryColor.withOpacity(0.5)),
                        child: Center(
                            child: Text(
                          replacePersianNum('10'),
                          style: TextStyle(
                              fontFamily: Fonts.Bold, color: Colors.white),
                        )),
                      ),
                    )),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        homeController.select25Score();
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              width: homeController.currentTypeIndex.value == 2
                                  ? 3
                                  : 0,
                            ),
                            color: primaryColor.withOpacity(0.75)),
                        child: Center(
                            child: Text(
                          replacePersianNum('25'),
                          style: TextStyle(
                              fontFamily: Fonts.Bold, color: Colors.white),
                        )),
                      ),
                    )),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        homeController.select50Score();
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              width: homeController.currentTypeIndex.value == 3
                                  ? 3
                                  : 0,
                            ),
                            color: primaryColor),
                        child: Center(
                            child: Text(
                          replacePersianNum('50'),
                          style: TextStyle(
                              fontFamily: Fonts.Bold, color: Colors.white),
                        )),
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'امتیاز این بازی',
                  style: TextStyle(fontFamily: Fonts.Bold, fontSize: 18),
                ),
                Text(
                  replacePersianNum(homeController.currentTypeScore.toString()),
                  style: TextStyle(fontFamily: Fonts.Black, fontSize: 28),
                ),
                Spacer(
                  flex: 2,
                ),
                GestureDetector(
                  onTap: () {
                    Get.offNamed(Routes.GAME);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                        child: Text(
                      'شروع',
                      style: TextStyle(
                          fontFamily: Fonts.Bold, color: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
