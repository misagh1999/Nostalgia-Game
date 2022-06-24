import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/routes/app_pages.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

class OnlineGameController extends GetxController {
  late Socket socket;

  TextEditingController aliasTextController = TextEditingController();

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

  RxString get messageTitle {
    var result = "----";

    if (isYourTurn.value) {
      result = 'حریف شما در حال حدس زدن است';
      if (canSelect.value) {
        result = "گزینه خود را انتخاب کنید";
      }
      if (canGuess.value) {
        result = "حدس خود را بزنید";
      }
    } else {
      result = "حریف شما در حال انتخاب است";
      if (canGuess.value) {
        result = 'حدس خود را بنویسید';
      }
    }

    return result.obs;
  }

  RxString get resultMessage {
    var result = "----";
    if (!canGuess.value && !canSelect.value) {
      if (isYourTurn.value) {
        if (guessTrue.value) {
          result = 'حدس شما درست بود';
        } else {
          result = 'حدس شما اشتباه بود';
        }
      } else {
        if (guessTrue.value) {
          result = 'حدس حریف‌تان درست بود';
        } else {
          result = 'حدس حریف‌تان اشتباه بود';
        }
      }
    }

    return result.obs;
  }

  @override
  void onClose() {
    socket.disconnect();
    super.onClose();
  }

  @override
  void onInit() {
    var uuid = Uuid();

    yourId.value = uuid.v4();
    
    socket = io(
      // 'ws://192.168.1.70:3000',
      'http://misaghpour-dev.ir',
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print('connected to websocket2');
    });

    _listenSockets();

    super.onInit();
  }

  _listenSockets() {
    socket.on('canPlay', (data) {
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

    socket.on('onSelect', (data) {
      final Map<String, dynamic> message = data;

      print('onSelect');
      print(message);

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

    socket.on('onGuess', (data) {
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
          } else {
            guessTrue.value = true;
          }
        }

        if (turnIndex.value == 1) {
          turnIndex.value = 2;
        } else if (turnIndex.value == 2) {
          turnIndex.value = 1;
          restTurn.value = restTurn.value - 1;
        }
      }
    });
  }

  onSelectBox(int box) {
    socket.emit('onSelect', {
      "boxNumber": box.toString(),
      "senderId": yourId.value,
      "recieverId": rivalId.value
    });

    selectedBox.value = box;
  }

  onGuessBox(int box) {
    socket.emit('onGuess', {
      "boxNumber": box.toString(),
      "senderId": yourId.value,
      "recieverId": rivalId.value
    });

    if (box != selectedBox.value) {
      yourLive.value = yourLive.value - 1;
      guessTrue.value = false;
    } else {
      guessTrue.value = true;
    }

    isYourTurn.value = !isYourTurn.value;
    canGuess.value = false;
    canSelect.value = true;

    if (turnIndex.value == 1) {
      turnIndex.value = 2;
    } else if (turnIndex.value == 2) {
      turnIndex.value = 1;
      restTurn.value = restTurn.value - 1;
    }
  }

  onClickBox(int box) {
    if (canSelect.value) {
      onSelectBox(box);
      canSelect.value = false;
    }

    if (canGuess.value) {
      onGuessBox(box);
      canGuess.value = false;
    }
  }

  requestToJoin() {
    if (aliasTextController.text.isNotEmpty) {
      yourAlias.value = aliasTextController.text;
      socket.emit('join', {"id": yourId.value, "alias": yourAlias.value});
      aliasTextController.text = "";
      isFinding.value = true;
    }
  }
}
