import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:handy_dandy_app/data/enums/result_online_game.dart';
import 'package:handy_dandy_app/widgets/app_bar.dart';

class FinishGameScreen extends StatelessWidget {
  FinishGameScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final result = Get.arguments['result'] as ResultGame;
    return Scaffold(
      appBar: buildMyAppBar(title: 'Finish'),
      body: WillPopScope(
        onWillPop: () {
          return _willPopScope();
        },
        child: SafeArea(
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
                    _getImagePath(result),
                    color: _getColor(result),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  _getMessage(result),
                  style: TextStyle(
                      fontFamily: Fonts.Black,
                      fontSize: 20,
                      color: _getColor(result)),
                ),
                Divider(),
                SizedBox(
                  height: 16,
                ),
                _buildBackButton()
              ],
            )),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildBackButton() {
    return GestureDetector(
      onTap: () {
        _willPopScope();
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: primaryColor),
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
                  color: Colors.white, fontFamily: Fonts.Black, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  String _getImagePath(ResultGame result) {
    switch (result) {
      case ResultGame.lose:
        return "assets/images/sad-face.svg";
      case ResultGame.win:
        return "assets/images/happy-face.svg";
      default:
    }
    return "assets/images/sad-face.svg";
  }

  Color _getColor(ResultGame result) {
    switch (result) {
      case ResultGame.win:
        return Colors.green;
      case ResultGame.lose:
        return Colors.red;
      default:
    }
    return Colors.orange;
  }

  String _getMessage(ResultGame result) {
    switch (result) {
      case ResultGame.lose:
        return "You Lost";
      case ResultGame.win:
        return "You Won";
      default:
    }
    return "Nobody Won";
  }

  _willPopScope() {
    Get.back();
    Get.back();
    Get.back();
  }
}
