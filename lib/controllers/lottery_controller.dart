import 'dart:math';

import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/home_controller.dart';
import 'package:hive/hive.dart';

class LotteryController extends GetxController {
  List<int> scores = [25, 50, 75, 100, 125, 150, 200, 250, 300];
  RxInt resultScore = 0.obs;

  final HomeController homeController = Get.find();

  RxBool isLoading = false.obs;

  RxBool canTry = true.obs;
  RxBool canReturn = false.obs;

  @override
  void onInit() {
    _checkCanTryLottery();
    super.onInit();
  }

  _checkCanTryLottery() async {
    Box box = await Hive.openBox('db');
    var lastTryCache = box.get('last_try_lottery');
    if (lastTryCache != null) {
      final lastDayTry = box.get('last_try_lottery') as int;
      final today = DateTime.now().day;
      if (today == lastDayTry) {
        canTry.value = false;
      } else {
        canTry.value = true;
      }
    }
  }

  tryLottery() async {
    isLoading.value = true;
    final startInt = 0;
    final endInt = scores.length - 1;
    Random random = Random();
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(milliseconds: 80), () {
        final resultIndex = random.nextInt(endInt + 1 - startInt) + startInt;
        resultScore.value = scores[resultIndex];
      });
    }
    Box box = await Hive.openBox('db');
    final today = DateTime.now().day;
    box.put('last_try_lottery', today);
    canReturn.value = true;
    isLoading.value = false;
    // todo: add result to firebase
    homeController.analytics.logEvent(
        name: 'try_lottery',
        parameters: <String, dynamic>{"score": resultScore.value});
    homeController.addLotteryScore(resultScore.value);
  }
}
