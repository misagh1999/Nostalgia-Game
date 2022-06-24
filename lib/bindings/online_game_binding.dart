import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/online_game_controller.dart';

class OnlineGameBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnlineGameController());
  }
}
