import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/constants.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

import '../data/enums/fe_socket_events.dart';
import '../data/my_cache.dart';
import '../routes/app_pages.dart';
import 'network_controller.dart';

class GameController extends GetxController {
  RxString gameTitle = "بازی".obs;
  RxBool isOnlineMode = false.obs;
  RxString gameDescription = "توضیحات این بازی که خوب است.".obs;

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

  RxBool isYourTurn = false.obs;
  Rx<Color> yourColor = Colors.grey.withOpacity(0.2).obs;
  RxString yourAlias = "شما".obs;
  RxInt yourLive = 3.obs;

  RxString yourId = "".obs;

  RxBool isRivalTurn = false.obs;
  Rx<Color> rivalColor = Colors.grey.withOpacity(0.2).obs;
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
      'ws://192.168.1.70:3000',
      // 'https://hobby.misaghpour-dev.ir',
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
      //
      socket.emit(FeSocketEvents.ONLINE_PLAYERS);
      _listenFillEmptyEvents();
    } else if (myGameType == MyGameType.handRock) {
      //
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

  _listenHandRockEvents() {
    //
  }

  @override
  void onClose() {
    socket.disconnect();
    socket.dispose();
    super.onClose();
  }

  onPlayButton() {
    if (homeController.totalScore.value >=
        homeController.currentTypeScore.value) {
      if (aliasTextController.text.trim() != "") {
        yourAlias.value = aliasTextController.text.trim();
        _cacheAlias(yourAlias.value);

        if (myGameType == MyGameType.fillEmpty) {
          socket.emit(FeSocketEvents.ON_JOIN,
              {"id": yourId.value, "alias": yourAlias.value});
        } else if (myGameType == MyGameType.handRock) {
          // todo: socket another join
        }

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
      Fluttertoast.showToast(msg: 'امتیاز شما مجاز نمی‌باشد');
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
