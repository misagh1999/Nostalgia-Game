import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/hand_rock_controller.dart';

class HandRockBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HandRockController());
  }
}
