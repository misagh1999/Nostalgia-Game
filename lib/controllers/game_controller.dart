import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/routes/app_pages.dart';

class GameController extends GetxController {
  RxInt restTurn = 5.obs;
  RxInt live = 3.obs;

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
    print(_boxNumber);
  }

  onSelectBox1() {
    // todo:
    selectedBox.value = 1;
    _checkAnswer(1);
  }

  onSelectBox2() {
    // todo:
    selectedBox.value = 2;
    _checkAnswer(2);
  }

  nextTurn() {
    isSelectState.value = true;
    // todo: next int
    restTurn.value = restTurn.value - 1;
    // check if exit
    _setRandomBox();
    if (restTurn.value == 0) {
      // finished
      _finishGame();
    }
  }

  _finishGame() {
    if (live.value == 0) {
      // todo: show dialog you are ok
      Get.offNamed(Routes.FINISH_GAME, arguments: {"isWin": false});
    } else {
      // todo: show successfull dialog
      Get.offNamed(Routes.FINISH_GAME, arguments: {"isWin": true});
    }
  }

  _checkAnswer(int boxNumber) {
    isSelectState.value = false;
    if (boxNumber == _boxNumber) {
      // todo: ok
      message.value = 'پاسخ درست';
      isTrue.value = true;
    } else {
      // todo: false
      message.value = 'پاسخ ناصحیح';
      live.value = live.value - 1;
      isTrue.value = false;
    }
    if (live.value == 0) {
      //
      _finishGame();
    }
  }
}
