import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:handy_dandy_app/routes/app_pages.dart';
import 'package:handy_dandy_app/widgets/dialog.dart';

class GameController extends GetxController {
  RxInt restTurn = 5.obs;
  RxInt live = 3.obs;

  final HomeController homeController = Get.find();

  int _boxNumber = -1;

  RxString message = "".obs;
  RxBool isTrue = false.obs;
  RxBool isSelectState = true.obs;
  RxInt selectedBox = 0.obs;

  Rx<Color> get boxColor1 {
    var result = Colors.grey;
    if (isSelectState.value) {
      result = Colors.orange;
    } else {
      if (selectedBox.value == 1) {
        if (isTrue.value) {
          result = Colors.green;
        } else {
          result = Colors.red;
        }
      } else {
        if (!isTrue.value) {
          result = Colors.green;
        }
      }
    }
    return result.obs;
  }

  Rx<Color> get boxColor2 {
    var result = Colors.grey;
    if (isSelectState.value) {
      result = Colors.orange;
    } else {
      if (selectedBox.value == 2) {
        if (isTrue.value) {
          result = Colors.green;
        } else {
          result = Colors.red;
        }
      } else {
        if (!isTrue.value) {
          result = Colors.green;
        }
      }
    }
    return result.obs;
  }

  @override
  void onInit() {
    _setRandomBox();
    super.onInit();
  }

  _setRandomBox() {
    int start = 1;
    int end = 2;
    Random random = Random();
    _boxNumber = random.nextInt(end + 1 - start) + start;
  }

  onSelectBox1() {
    selectedBox.value = 1;
    _checkAnswer(1);
  }

  onSelectBox2() {
    selectedBox.value = 2;
    _checkAnswer(2);
  }

  nextTurn() {
    isSelectState.value = true;
    _setRandomBox();
  }

  onWillPop() {
    showMyDialog(
        title: 'خروج از بازی',
        message: 'آیا برای خروج اطمینان دارید؟',
        onCancel: () {
          Get.back();
        },
        onConfirm: () {
          Get.back();
          Get.back();
        });
  }

  _finishGame() async {
    if (live.value == 0) {
      await homeController.subtractScore();
      Get.offNamed(Routes.FINISH_GAME, arguments: {"isWin": false});
    } else {
      await homeController.addScore();
      Get.offNamed(Routes.FINISH_GAME, arguments: {"isWin": true});
    }
  }

  _checkAnswer(int boxNumber) {
    isSelectState.value = false;
    restTurn.value = restTurn.value - 1;
    if (boxNumber == _boxNumber) {
      message.value = 'پاسخ درست';
      isTrue.value = true;
    } else {
      message.value = 'پاسخ ناصحیح';
      live.value = live.value - 1;
      isTrue.value = false;
    }
    if (live.value == 0) {
      _finishGame();
    }
    if (restTurn.value == 0) {
      _finishGame();
    }
  }
}
