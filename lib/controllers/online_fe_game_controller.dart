import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:handy_dandy_app/controllers/network_controller.dart';
import 'package:handy_dandy_app/data/enums/result_online_game.dart';
import 'package:handy_dandy_app/data/my_cache.dart';
import 'package:handy_dandy_app/routes/app_pages.dart';
import 'package:handy_dandy_app/utils/ui_utils.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

import '../data/enums/fe_socket_events.dart';
import '../widgets/dialog.dart';

class OnlineFeGameController extends GetxController {
  late Socket socket;

  TextEditingController aliasTextController = TextEditingController();
  final NetworkController networkController = Get.find();
  final HomeController homeController = Get.find();

  RxBool get hasInternetConnection {
    var result = false;
    result = networkController.connectionType.value != 0;
    return result.obs;
  }

  RxString yourId = "".obs;
  RxString rivalId = "".obs;

  RxString yourAlias = "".obs;
  RxString rivalAlias = "".obs;

  RxInt restTurn = 5.obs;
  RxInt turnIndex = 0.obs;

  RxInt yourLive = 3.obs;
  RxInt rivalLive = 3.obs;

  RxBool isFinding = false.obs;
  RxBool isYourTurn = false.obs;

  RxBool canSelect = false.obs;
  RxBool canGuess = false.obs;

  RxInt selectedBox = 0.obs;

  RxBool guessTrue = false.obs;

  Rx<Color> yourColor = Colors.white.obs;
  Rx<Color> rivalColor = Colors.white.obs;

  RxBool isSelectingRival = false.obs;

  RxInt totalOnlinePlayers = 0.obs;

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
  void onClose() {
    socket.disconnect();
    socket.dispose();
    super.onClose();
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

  @override
  void onInit() {
    var uuid = Uuid();

    _readAliasFromCache();

    homeController.select50Score();

    yourId.value = uuid.v4();

    socket = io(
      'ws://192.168.1.70:3000',
      // 'https://hobby.misaghpour-dev.ir',
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build(),
    );

    socket.onConnectError((data) => print(data));

    socket.connect();

    socket.onConnect((_) {
      print('connected to websocket2');

      socket.emit(FeSocketEvents.ONLINE_PLAYERS);
    });

    _listenSockets();

    super.onInit();
  }

  _readAliasFromCache() {
    MyCache.loadAlias(aliasTextController);
  }

  _cacheAlias(String alias) async {
    MyCache.cacheAlias(alias);
  }

  reConnectSocket() {
    if (networkController.connectionType.value != 0) socket.connect();
  }

  _listenSockets() {
    socket.on(FeSocketEvents.CAN_PLAY, (data) {
      final message = data as Map<String, dynamic>;
      final player1 = message['player1'];
      final player2 = message['player2'];

      if ((player1["id"] as String) == yourId.value ||
          (player2["id"] as String) == yourId.value) {
        final player1Id = player1["id"] as String;
        final player2Id = player2["id"] as String;

        final player1Alias = player1["alias"] as String;
        final player2Alias = player2["alias"] as String;

        if (yourId.value == player1Id) {
          isYourTurn.value = true;
          canSelect.value = true;
          canGuess.value = false;

          rivalId.value = player2Id;
          rivalAlias.value = player2Alias;
        } else {
          isYourTurn.value = false;
          canSelect.value = false;
          canGuess.value = false;

          rivalId.value = player1Id;
          rivalAlias.value = player1Alias;
        }

        turnIndex.value = 1;

        isFinding.value = false;
        Get.toNamed(Routes.ONLINE_GAME);
      }
    });

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
      }
    });

    socket.on(FeSocketEvents.ONLINE_PLAYERS, (data) {
      final Map<String, dynamic> message = data;

      final totalNumbers = message['total'] as int;
      totalOnlinePlayers.value = totalNumbers;
    });

    socket.on(FeSocketEvents.ON_GUESS, (data) {
      final Map<String, dynamic> message = data;

      final rBoxNumber = int.parse(message['boxNumber'] as String);
      final rSenderId = message['senderId'] as String;
      final rReciverId = message['recieverId'] as String;

      if (rSenderId == rivalId.value && rReciverId == yourId.value) {
        if (isYourTurn.value) {
          isYourTurn.value = !isYourTurn.value;
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

  _onSelectBox(int box) {
    socket.emit(FeSocketEvents.ON_SELECT, {
      "boxNumber": box.toString(),
      "senderId": yourId.value,
      "recieverId": rivalId.value
    });

    selectedBox.value = box;
  }

  _onGuessBox(int box) {
    socket.emit(FeSocketEvents.ON_GUESS, {
      "boxNumber": box.toString(),
      "senderId": yourId.value,
      "recieverId": rivalId.value
    });

    if (box != selectedBox.value) {
      yourLive.value = yourLive.value - 1;
      guessTrue.value = false;
      blinkColor(yourColor, false);
    } else {
      guessTrue.value = true;
      blinkColor(yourColor, true);
    }

    isYourTurn.value = !isYourTurn.value;
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

  requestToJoin() {
    if (hasInternetConnection.value) {
      if (aliasTextController.text.trim() != "") {
        yourAlias.value = aliasTextController.text.trim();
        _cacheAlias(yourAlias.value);
        socket.emit(FeSocketEvents.ON_JOIN,
            {"id": yourId.value, "alias": yourAlias.value});
        isFinding.value = true;
        Future.delayed(Duration(seconds: 10), () {
          if (isFinding.value) {
            isFinding.value = false;
            Fluttertoast.showToast(msg: 'حریفی پیدا نشد، مجدد تلاش کنید');
          }
        });
      } else {
        Fluttertoast.showToast(msg: 'نام مستعار خود را وارد کنید');
      }
    } else {
      Fluttertoast.showToast(msg: 'اتصال به اینترنت وجود ندارد');
    }
  }
}
