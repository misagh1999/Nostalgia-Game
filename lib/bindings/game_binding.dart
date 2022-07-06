import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/game_controller.dart';

import '../controllers/network_controller.dart';

class GameBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkController());
    Get.lazyPut(() => GameController());
  }
}
