import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/logic/hand_rock_rule.dart';

import '../data/enums/result_online_game.dart';
import '../routes/app_pages.dart';
import '../utils/ui_utils.dart';
import '../utils/utils.dart';
import 'game_controller.dart';
import 'home_controller.dart';

class HandRockController extends GetxController {
  RxInt restTurn = 5.obs;

  final GameController gController = Get.find();
  final HomeController homeController = Get.find();

  late RxBool isFinisedGame;

  late RxString yourId;
  late RxInt yourLive;
  late Rx<Color> yourColor;

  late RxString rivalId;
  late RxString rivalAlias;
  late RxInt rivalLive;
  late Rx<Color> rivalColor;

  late RxBool isRivalTurn;
  late RxBool isYourTurn;

  Rx<Color> yourOptionColor = Colors.white.obs;
  Rx<Color> rivalOptionColor = Colors.white.obs;

  _restOptionColors() {
    yourOptionColor.value = Colors.white;
    rivalOptionColor.value = Colors.white;
  }

  Rx<RivalStatus> rivalStatus = RivalStatus.idle.obs;
  Rx<RivalStatus> yourStatus = RivalStatus.idle.obs;

  Rx<OptionType> yourOptionType = OptionType.nothing.obs;
  Rx<OptionType> rivalOptionType = OptionType.nothing.obs;

  Rx<IconData> get yourOptionIcon {
    var result = FontAwesomeIcons.a;

    switch (yourOptionType.value) {
      case OptionType.hand:
        result = FontAwesomeIcons.hand;
        break;
      case OptionType.scisors:
        result = FontAwesomeIcons.handScissors;
        break;
      case OptionType.rock:
        result = FontAwesomeIcons.handBackFist;
        break;
      default:
    }

    return result.obs;
  }

  Rx<IconData> get rivalOptionIcon {
    var result = FontAwesomeIcons.a;

    switch (rivalOptionType.value) {
      case OptionType.hand:
        result = FontAwesomeIcons.hand;
        break;
      case OptionType.scisors:
        result = FontAwesomeIcons.handScissors;
        break;
      case OptionType.rock:
        result = FontAwesomeIcons.handBackFist;
        break;
      default:
    }

    if (yourStatus.value == RivalStatus.isSelecting) {
      result = FontAwesomeIcons.question;
    }

    return result.obs;
  }

  RxString get rivalStatusStr {
    var result = "";
    if (rivalStatus.value == RivalStatus.isSelecting)
      result = "حریف شما در حال انتخاب است";
    else if (rivalStatus.value == RivalStatus.selected)
      result = "حریف شما انتخاب کرد";

    return result.obs;
  }

  @override
  void onInit() {
    _initVariables();
    isYourTurn.value = false;
    _retry();
    super.onInit();
  }

  _initVariables() {
    yourId = gController.yourId;
    yourLive = gController.yourLive;
    yourColor = gController.yourColor;
    isYourTurn = gController.isYourTurn;

    rivalId = gController.rivalId;
    rivalAlias = gController.rivalAlias;
    rivalLive = gController.rivalLive;
    rivalColor = gController.rivalColor;
    restTurn = gController.restTurn;
    isRivalTurn = gController.isRivalTurn;

    isFinisedGame = gController.isFinishedGame;
  }

  onChooseButton(OptionType optionType) {
    if (yourStatus.value == RivalStatus.isSelecting) {
      yourStatus.value = RivalStatus.selected;
      yourOptionType.value = optionType;

      _selectRobot();
    }
  }

  _selectRobot() async {
    await Future.delayed(Duration(seconds: 2));
    final guessNumber = randomNumber(1, 3);
    rivalStatus.value = RivalStatus.selected;
    var optionType = OptionType.nothing;
    switch (guessNumber) {
      case 1:
        optionType = OptionType.hand;
        break;
      case 2:
        optionType = OptionType.rock;
        break;
      case 3:
        optionType = OptionType.scisors;
        break;
      default:
    }
    rivalOptionType.value = optionType;

    _checkResult();
  }

  _retry() {
    _restOptionColors();
    rivalStatus.value = RivalStatus.isSelecting;
    yourStatus.value = RivalStatus.isSelecting;
  }

  _checkResult() async {
    var yourOptionStr = _optionTypeToStr(yourOptionType.value);
    var rivalOptionStr = _optionTypeToStr(rivalOptionType.value);

    var isYouWin = false;
    var isRivalWin = false;

    for (var role in hand_rock_rule) {
      if (role[YOUR_OPTION] == yourOptionStr &&
          role[RIVAL_OPTION] == rivalOptionStr) {
        isYouWin = role[YOUR_WIN] as bool;
        isRivalWin = role[RIVAL_WIN] as bool;
      }
    }
    if (!isYouWin) {
      yourLive.value = yourLive.value - 1;
      blinkColor(yourColor, false);
      yourOptionColor.value = Colors.red;
    } else {
      yourOptionColor.value = Colors.green;
    }

    if (!isRivalWin) {
      rivalLive.value = rivalLive.value - 1;
      blinkColor(rivalColor, false);
      rivalOptionColor.value = Colors.red;
    } else {
      rivalOptionColor.value = Colors.green;
    }

    restTurn.value = restTurn.value - 1;

    await Future.delayed(Duration(seconds: 2));

    _retry();

    _checkFinishGame();
  }

  _checkFinishGame() {
    ResultGame result = ResultGame.equal;
    if (yourLive.value == 0 || rivalLive.value == 0) {
      if (yourLive.value == rivalLive.value) {
        result = ResultGame.equal;
      } else if (yourLive.value == 0) {
        result = ResultGame.lose;
      } else if (rivalLive.value == 0) {
        result = ResultGame.win;
      }

      _goToFinishScreen(result);
    } else if (restTurn.value == 0) {
      if (yourLive.value == rivalLive.value) {
        result = ResultGame.equal;
      } else if (yourLive.value > rivalLive.value) {
        result = ResultGame.win;
      } else if (yourLive.value < rivalLive.value) {
        result = ResultGame.lose;
      }

      _goToFinishScreen(result);
    }
  }

  _goToFinishScreen(ResultGame result) {
    isFinisedGame.value = true;
    switch (result) {
      case ResultGame.lose:
        homeController.subtractScore();
        break;
      case ResultGame.win:
        homeController.addScore();
        break;
      default:
    }

    Get.toNamed(Routes.FINISH_GAME, arguments: {"result": result});
  }

  _optionTypeToStr(OptionType optionType) {
    var result = "";
    switch (optionType) {
      case OptionType.hand:
        result = PAPER;
        break;
      case OptionType.scisors:
        result = SCISSORS;
        break;
      case OptionType.rock:
        result = ROCK;
        break;
      default:
    }
    return result;
  }

  _strToOptionType(String optionStr) {
    var optionType = OptionType.nothing;
    switch (optionStr) {
      case PAPER:
        optionType = OptionType.hand;
        break;
      case SCISSORS:
        optionType = OptionType.scisors;
        break;
      case ROCK:
        optionType = OptionType.rock;
        break;
      default:
    }
    return optionType;
  }
}

enum RivalStatus { idle, isSelecting, selected }

enum OptionType { nothing, hand, rock, scisors }
