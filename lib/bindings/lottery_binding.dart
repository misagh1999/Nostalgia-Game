import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/lottery_controller.dart';

class LotteryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LotteryController());
  }
}
