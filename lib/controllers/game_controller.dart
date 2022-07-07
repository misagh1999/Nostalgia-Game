import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:handy_dandy_app/data/enums/hr_socket_events.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

import '../data/enums/fe_socket_events.dart';
import '../data/my_cache.dart';
import '../routes/app_pages.dart';
import '../widgets/dialog.dart';
import 'network_controller.dart';

const ROBOT_ID = "99999999";
const ROBOT_ALIAS = 'ربات';

class GameController extends GetxController {
  RxString gameTitle = "بازی".obs;
  RxBool isOnlineMode = false.obs;
  RxString gameDescription = "توضیحات این بازی که خوب است.".obs;

  RxBool isFinishedGame = false.obs;

  final HomeController homeController = Get.find();

  TextEditingController aliasTextController = TextEditingController();

  RxInt restTurn = 5.obs;

  RxInt totalOnlinePlayers = 0.obs;

  RxBool isFinding = false.obs;

  late Socket socket;

  final NetworkController networkController = Get.find();

  RxBool get hasInternetConnection {
    var result = false;
    result = networkController.connectionType.value != 0;
    return result.obs;
  }

  RxString get errorPlayGameStr {
    var result = "";

    if (homeController.totalScore.value <
        homeController.currentTypeScore.value) {
      result = 'مجموع امتیاز شما برای بازی کافی نیست';
    }

    if (aliasTextController.text.trim() == "") {
      result = 'نام مستعار خود را وارد کنید';
    }

    if (isOnlineMode.value) {
      if (!hasInternetConnection.value) {
        result = 'اتصال شما به اینترنت برقرار نیست';
      }
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

    _initSocketIo();

    super.onInit();
  }

  @override
  void onReady() {
    setOfflineMode();
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

  reConnectSocket() {
    if (networkController.connectionType.value != 0) socket.connect();
  }

  _readAliasFromCache() {
    MyCache.loadAlias(aliasTextController);
  }

  _cacheAlias(String alias) async {
    MyCache.cacheAlias(alias);
  }

  _initSocketIo() {
    socket = io(
      // 'ws://192.168.1.70:3000',
      'https://hobby.misaghpour-dev.ir',
      OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
    );

    socket.onConnectError((data) => print(data));

    socket.connect();

    socket.onConnect((_) {
      print('connected to websocket2');
      _listenSocketEvents();
    });
  }

  _listenSocketEvents() {
    if (myGameType == MyGameType.fillEmpty) {
      socket.emit(FeSocketEvents.ONLINE_PLAYERS);
      _listenFillEmptyEvents();
    } else if (myGameType == MyGameType.handRock) {
      _listenHandRockEvents();
    }
  }

  _listenFillEmptyEvents() {
    socket.on(FeSocketEvents.ONLINE_PLAYERS, (data) {
      final Map<String, dynamic> message = data;

      final totalNumbers = message['total'] as int;
      totalOnlinePlayers.value = totalNumbers;
    });

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
    });
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

  _listenHandRockEvents() {
    socket.on(HrSocketEvents.ONLINE_PLAYERS, (data) {
      final Map<String, dynamic> message = data;

      final totalNumbers = message['total'] as int;
      totalOnlinePlayers.value = totalNumbers;
    });

    socket.on(HrSocketEvents.CAN_PLAY, (data) {
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
    });
  }

  @override
  void onClose() {
    socket.disconnect();
    socket.dispose();
    super.onClose();
  }

  onPlayButton() {
    if (errorPlayGameStr.value == "") {
      yourAlias.value = aliasTextController.text.trim();
      _cacheAlias(yourAlias.value);

      if (isOnlineMode.value) {
        isFinding.value = true;
        Future.delayed(Duration(seconds: 10), () {
          if (isFinding.value) {
            isFinding.value = false;
            Fluttertoast.showToast(msg: 'حریفی پیدا نشد، مجدد تلاش کنید');
          }
        });
      }

      if (myGameType == MyGameType.fillEmpty) {
        if (isOnlineMode.value) {
          socket.emit(FeSocketEvents.ON_JOIN,
              {"id": yourId.value, "alias": yourAlias.value});
        } else {
          _onPlayOfflineGame();
        }
      } else if (myGameType == MyGameType.handRock) {
        if (isOnlineMode.value) {
          socket.emit(HrSocketEvents.ON_JOIN,
              {"id": yourId.value, "alias": yourAlias.value});
        } else {
          _onPlayOfflineGame();
        }
      }
    } else {
      Fluttertoast.showToast(msg: errorPlayGameStr.value);
    }
  }

  setOnlineMode() {
    isOnlineMode.value = true;
    homeController.select50Score();
  }

  setOfflineMode() {
    isOnlineMode.value = false;
  }
}

enum MyGameType { fillEmpty, handRock }
