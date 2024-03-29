import 'package:get/get.dart';
import 'package:handy_dandy_app/bindings/game_binding.dart';
import 'package:handy_dandy_app/bindings/home_binding.dart';
import 'package:handy_dandy_app/bindings/lottery_binding.dart';
import 'package:handy_dandy_app/screens/daily_lottery/daily_lottery_screen.dart';
import 'package:handy_dandy_app/screens/finish_game/finish_game_screen.dart';
import 'package:handy_dandy_app/screens/home/home_screen.dart';
import 'package:handy_dandy_app/screens/main_game/main_game_screen.dart';
import 'package:handy_dandy_app/screens/ready_game/ready_game_screen.dart';
import 'package:handy_dandy_app/screens/welcome/welcome_screen.dart';

part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.WELCOME, page: () => WelcomeScreen()),
    GetPage(
        name: Routes.HOME, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(name: Routes.FINISH_GAME, page: () => FinishGameScreen()),
    GetPage(
        name: Routes.READY_GAME,
        page: () => ReadyGameScreen(),
        binding: GameBinding()),
    GetPage(name: Routes.MAIN_GAME, page: () => MainGameScreen()),
    GetPage(
        name: Routes.DAILY_LOTTERY,
        page: () => DailyLotteryScreen(),
        binding: LotteryBinding()),
  ];
}
