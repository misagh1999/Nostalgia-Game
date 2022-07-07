import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/game_controller.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:handy_dandy_app/utils/utils.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../data/enums/fe_socket_events.dart';
import '../data/enums/result_online_game.dart';
import '../routes/app_pages.dart';
import '../utils/ui_utils.dart';

class FillEmptyController extends GetxController {
  RxBool canSelect = true.obs;
  RxBool canGuess = true.obs;

  RxInt turnIndex = 0.obs;

  late RxBool isYourTurn;
  late RxBool isRivalTurn;

  late Socket socket;

  RxInt selectedBox = 0.obs;

  RxBool guessTrue = false.obs;

  RxBool isYouSelected = false.obs;

  late RxInt restTurn;

  final GameController gController = Get.find();
  final HomeController homeController = Get.find();

  late RxString yourId;
  late RxInt yourLive;
  late Rx<Color> yourColor;

  late RxString rivalId;
  late RxString rivalAlias;
  late RxInt rivalLive;
  late Rx<Color> rivalColor;

  Rx<Color> get box1Color {
    var result = primaryColor;
    if (isYouSelected.value) {
      if (selectedBox.value == 1) {
        result = primaryColor;
      } else if (selectedBox.value == 2) {
        result = Colors.grey;
      }
    }

    if (isSelectingRival.value && !isYourTurn.value) {
      result = Colors.grey;
    }

    return result.obs;
  }

  Rx<Color> get box2Color {
    var result = primaryColor;
    if (isYouSelected.value) {
      if (selectedBox.value == 2) {
        result = primaryColor;
      } else if (selectedBox == 1) {
        result = Colors.grey;
      }
    }

    if (isSelectingRival.value && !isYourTurn.value) {
      result = Colors.grey;
    }

    return result.obs;
  }

  RxBool isSelectingRival = false.obs;

  late RxBool isOnlineMode;

  RxString get messageTitle {
    var result = "----";
    isSelectingRival.value = true;

    if (isYourTurn.value) {
      result = 'حریف شما در حال حدس زدن است';
      if (canSelect.value) {
        result = "گزینه خود را انتخاب کنید";
        isSelectingRival.value = false;
      }
      if (canGuess.value) {
        result = "حدس خود را بزنید";
        isSelectingRival.value = false;
      }
    } else {
      result = "حریف شما در حال انتخاب است";
      if (canGuess.value) {
        result = 'حدس خود را بزنید';
        isSelectingRival.value = false;
      }
    }

    return result.obs;
  }

  @override
  void onInit() {
    _initVariables();
    _initializePlayers();
    if (isOnlineMode.value) {
      socket = gController.socket;
      _listenSockets();
    }

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

    isOnlineMode = gController.isOnlineMode;
  }

  _initializePlayers() {
    final player1 = Get.arguments['player1'] as Map<String, dynamic>;
    final player2 = Get.arguments['player2'] as Map<String, dynamic>;

    final player1Id = player1["id"] as String;
    final player2Id = player2["id"] as String;

    final player1Alias = player1["alias"] as String;
    final player2Alias = player2["alias"] as String;

    if (yourId.value == player1Id) {
      isYourTurn.value = true;
      isRivalTurn.value = false;

      canSelect.value = true;
      canGuess.value = false;

      rivalId.value = player2Id;
      rivalAlias.value = player2Alias;
    } else {
      isYourTurn.value = false;
      isRivalTurn.value = true;

      canSelect.value = false;
      canGuess.value = false;

      rivalId.value = player1Id;
      rivalAlias.value = player1Alias;
    }

    turnIndex.value = 1;
  }

  @override
  void onClose() {
    if (isOnlineMode.value) {
      socket.disconnect();
      socket.dispose();
    }

    super.onClose();
  }

  _listenSockets() {
    socket.on(FeSocketEvents.ON_SELECT, (data) {
      final Map<String, dynamic> message = data;

      final rBoxNumber = int.parse(message['boxNumber'] as String);
      final rSenderId = message['senderId'] as String;
      final rReciverId = message['recieverId'] as String;

      if (rSenderId == rivalId.value && rReciverId == yourId.value) {
        if (!isYourTurn.value) {
          canGuess.value = true;
          selectedBox.value = rBoxNumber;
        } else {
          selectedBox.value = rBoxNumber;
          canSelect.value = false;
          canGuess.value = false;
        }

        isYouSelected.value = false;
      }
    });

    socket.on(FeSocketEvents.ON_GUESS, (data) {
      final Map<String, dynamic> message = data;

      final rBoxNumber = int.parse(message['boxNumber'] as String);
      final rSenderId = message['senderId'] as String;
      final rReciverId = message['recieverId'] as String;

      if (rSenderId == rivalId.value && rReciverId == yourId.value) {
        if (isYourTurn.value) {
          isYourTurn.value = !isYourTurn.value;
          isRivalTurn.value = true;

          canGuess.value = false;
          canSelect.value = false;

          if (selectedBox.value != rBoxNumber) {
            rivalLive.value = rivalLive.value - 1;
            guessTrue.value = false;
            blinkColor(rivalColor, false);
          } else {
            guessTrue.value = true;
            blinkColor(rivalColor, true);
          }
        }

        isYouSelected.value = false;

        if (turnIndex.value == 1) {
          turnIndex.value = 2;
        } else if (turnIndex.value == 2) {
          turnIndex.value = 1;
          restTurn.value = restTurn.value - 1;
          _checkFinishGame();
        }
      }
    });

    socket.on(FeSocketEvents.ON_DISCONNECT_RIVAL, (data) async {
      Get.back();
      Get.back();
      await Future.delayed(Duration(milliseconds: 500));
      Get.snackbar('قطع اتصال حریف', 'رقیب شما از بازی خارج شد',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          padding: EdgeInsets.all(16),
          duration: Duration(seconds: 4));
    });
  }

  onClickBox(int box) {
    if (canSelect.value) {
      _onSelectBox(box);
      canSelect.value = false;
    }

    if (canGuess.value) {
      _onGuessBox(box);
      canGuess.value = false;
    }
  }

  _onSelectBox(int box) {
    isYouSelected.value = true;

    if (isOnlineMode.value) {
      socket.emit(FeSocketEvents.ON_SELECT, {
        "boxNumber": box.toString(),
        "senderId": yourId.value,
        "recieverId": rivalId.value
      });
    } else {
      _guessRobot();
    }

    selectedBox.value = box;
  }

  _selectRobot() async {
    await Future.delayed(Duration(seconds: 2));
    final selectNumber = randomNumber(1, 2);
    if (!isYourTurn.value) {
      canGuess.value = true;
      selectedBox.value = selectNumber;
    } else {
      selectedBox.value = selectNumber;
      canSelect.value = false;
      canGuess.value = false;
    }
  }

  _guessRobot() async {
    await Future.delayed(Duration(seconds: 2));
    final guessNumber = randomNumber(1, 2);

    if (isYourTurn.value) {
      isYourTurn.value = !isYourTurn.value;
      isRivalTurn.value = true;

      canGuess.value = false;
      canSelect.value = false;

      if (selectedBox.value != guessNumber) {
        rivalLive.value = rivalLive.value - 1;
        guessTrue.value = false;
        blinkColor(rivalColor, false);
      } else {
        guessTrue.value = true;
        blinkColor(rivalColor, true);
      }
    }

    isYouSelected.value = false;

    _selectRobot();

    if (turnIndex.value == 1) {
      turnIndex.value = 2;
    } else if (turnIndex.value == 2) {
      turnIndex.value = 1;
      restTurn.value = restTurn.value - 1;
      _checkFinishGame();
    }
  }

  _onGuessBox(int box) async {
    if (isOnlineMode.value) {
      socket.emit(FeSocketEvents.ON_GUESS, {
        "boxNumber": box.toString(),
        "senderId": yourId.value,
        "recieverId": rivalId.value
      });
    }

    if (box != selectedBox.value) {
      yourLive.value = yourLive.value - 1;
      guessTrue.value = false;
      blinkColor(yourColor, false);
    } else {
      guessTrue.value = true;
      blinkColor(yourColor, true);
    }

    isYourTurn.value = !isYourTurn.value;
    isRivalTurn.value = !isRivalTurn.value;
    canGuess.value = false;
    canSelect.value = true;

    if (turnIndex.value == 1) {
      turnIndex.value = 2;
    } else if (turnIndex.value == 2) {
      turnIndex.value = 1;
      restTurn.value = restTurn.value - 1;
      _checkFinishGame();
    }
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
}
