import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/network_controller.dart';
import 'package:handy_dandy_app/controllers/online_game_controller.dart';

class OnlineGameBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkController());
    Get.lazyPut(() => OnlineGameController());
  }
}
