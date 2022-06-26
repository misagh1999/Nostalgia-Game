import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  RxInt totalScore = 0.obs;
  RxInt currentTypeScore = 25.obs;
  RxInt currentTypeIndex = 2.obs;

  @override
  void onInit() {
    _initData();
    super.onInit();
  }

  _initData() async {
    Box box = await Hive.openBox('db');
    var totalScoreCache = box.get('total_score');
    if (totalScoreCache == null) {
      box.put('total_score', 250);
      totalScore.value = 250;
    } else {
      totalScore.value = box.get('total_score') as int;
    }
  }

  select10Score() {
    currentTypeScore.value = 10;
    currentTypeIndex.value = 1;
  }

  select25Score() {
    currentTypeScore.value = 25;
    currentTypeIndex.value = 2;
  }

  select50Score() {
    currentTypeScore.value = 50;
    currentTypeIndex.value = 3;
  }

  addScore() async {
    totalScore.value = totalScore.value + currentTypeScore.value;
    Box box = await Hive.openBox('db');
    box.put('total_score', totalScore.value);
  }

  addLotteryScore(int score) async {
    totalScore.value = totalScore.value + score;
    Box box = await Hive.openBox('db');
    box.put('total_score', totalScore.value);
  }

  subtractScore() async {
    totalScore.value = totalScore.value - currentTypeScore.value;
    Box box = await Hive.openBox('db');
    box.put('total_score', totalScore.value);
  }
}
