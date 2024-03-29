import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/lottery_controller.dart';
import 'package:handy_dandy_app/widgets/app_bar.dart';

class DailyLotteryScreen extends StatelessWidget {
  DailyLotteryScreen({Key? key}) : super(key: key);

  final LotteryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(title: 'Daily Lottery'),
      body: SafeArea(
        child: Obx(
          () => Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.canTry.value ? _buildCanTry() : _buildCanNotTry(),
                  SizedBox(
                    height: 16,
                  ),
                  controller.canReturn.value || !controller.canTry.value
                      ? _buildBackButton()
                      : _buildTryButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Stack _buildCanTry() {
    return Stack(
      alignment: Alignment.center,
      children: [
        controller.isLoading.value
            ? Align(
                alignment: Alignment.center,
                child: SpinKitCircle(
                  color: primaryColor,
                  size: 150,
                ),
              )
            : SizedBox(
                height: 150,
              ),
        Align(
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 40),
            child: Text(
              controller.resultScore.toString(),
              style: TextStyle(fontFamily: Fonts.Bold, fontSize: 40),
            ),
          ),
        )
      ],
    );
  }

  Container _buildCanNotTry() {
    return Container(
      child: Column(
        children: [
          FaIcon(
            FontAwesomeIcons.faceFrown,
            size: Get.width / 4,
            color: Colors.deepOrange[700],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'You have tried your chance today!',
            style: TextStyle(
              fontFamily: Fonts.Medium,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text('For another chance please try tommorow'),
        ],
      ),
    );
  }

  GestureDetector _buildTryButton() {
    return GestureDetector(
      onTap: () {
        controller.tryLottery();
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Try It',
              style: TextStyle(
                  fontFamily: Fonts.Bold, fontSize: 20, color: Colors.white),
            ),
            SizedBox(
              width: 8,
            ),
            FaIcon(
              FontAwesomeIcons.dice,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector _buildBackButton() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.arrowRight,
              color: Colors.white,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Back',
              style: TextStyle(
                  fontFamily: Fonts.Bold, fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
