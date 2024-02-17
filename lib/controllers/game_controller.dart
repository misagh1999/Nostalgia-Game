import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:uuid/uuid.dart';

import '../data/my_cache.dart';
import '../routes/app_pages.dart';
import '../widgets/dialog.dart';

const ROBOT_ID = "99999999";
const ROBOT_ALIAS = 'ربات';

class GameController extends GetxController {
  RxString gameTitle = "بازی".obs;
  RxString gameDescription = "توضیحات این بازی که خوب است.".obs;

  RxBool isFinishedGame = false.obs;

  final HomeController homeController = Get.find();

  TextEditingController aliasTextController = TextEditingController();

  RxInt restTurn = 5.obs;

  RxBool isFinding = false.obs;

  RxString get errorPlayGameStr {
    var result = "";

    if (homeController.totalScore.value <
        homeController.currentTypeScore.value) {
      result = 'مجموع امتیاز شما برای بازی کافی نیست';
    }

    if (aliasTextController.text.trim() == "") {
      result = 'نام مستعار خود را وارد کنید';
    }

    return result.obs;
  }

  RxBool isYourTurn = false.obs;
  Rx<Color> yourColor = lightGreyColor!.obs;
  RxString yourAlias = "شما".obs;
  RxInt yourLive = 3.obs;

  RxString yourId = "".obs;

  RxBool isRivalTurn = false.obs;
  Rx<Color> rivalColor = lightGreyColor!.obs;
  RxString rivalAlias = "حریف".obs;
  RxInt rivalLive = 3.obs;
  RxString rivalId = "".obs;

  RxString rivalStatusStr = "حریف شما در حال انتخاب است".obs;
  RxBool isLoadingRival = false.obs;

  late StatelessWidget mainBodyWidget;
  late MyGameType myGameType;

  @override
  void onInit() {
    var uuid = Uuid();

    _readAliasFromCache();

    yourId.value = uuid.v4();

    myGameType = Get.arguments['game'] as MyGameType;

    if (myGameType == MyGameType.fillEmpty) {
      gameTitle.value = 'گل یا پوچ';
      gameDescription.value = READY_DESC_FE;
    } else if (myGameType == MyGameType.handRock) {
      gameTitle.value = 'سنگ کاغذ قیچی';
      gameDescription.value = READY_DESC_HAND_ROCK;
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
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
          Get.back();
        });
  }

  _readAliasFromCache() {
    MyCache.loadAlias(aliasTextController);
  }

  _cacheAlias(String alias) async {
    MyCache.cacheAlias(alias);
  }

  _onPlayOfflineGame() {
    final player1 = {'id': yourId.value, 'alias': yourAlias.value};
    final player2 = {'id': ROBOT_ID, 'alias': ROBOT_ALIAS};

    final player1Id = player1["id"] as String;
    final player2Id = player2["id"] as String;

    final player1Alias = player1["alias"] as String;
    final player2Alias = player2["alias"] as String;

    if (yourId.value == player1Id) {
      isYourTurn.value = true;

      rivalId.value = player2Id;
      rivalAlias.value = player2Alias;
    } else {
      isYourTurn.value = false;

      rivalId.value = player1Id;
      rivalAlias.value = player1Alias;
    }

    isFinding.value = false;

    Get.toNamed(Routes.MAIN_GAME,
        arguments: {'player1': player1, 'player2': player2});
  }

  @override
  void onClose() {
    super.onClose();
  }

  onPlayButton() {
    if (errorPlayGameStr.value == "") {
      yourAlias.value = aliasTextController.text.trim();
      _cacheAlias(yourAlias.value);

      if (myGameType == MyGameType.fillEmpty) {
        _onPlayOfflineGame();
      } else if (myGameType == MyGameType.handRock) {
        _onPlayOfflineGame();
      }
    } else {
      Fluttertoast.showToast(msg: errorPlayGameStr.value);
    }
  }
}

enum MyGameType { fillEmpty, handRock }
