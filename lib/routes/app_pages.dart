import 'package:get/get.dart';
import 'package:handy_dandy_app/screens/game/game_screen.dart';
import 'package:handy_dandy_app/screens/home/home_screen.dart';
import 'package:handy_dandy_app/screens/login/login_screen.dart';
import 'package:handy_dandy_app/screens/signup/signup_screen.dart';
import 'package:handy_dandy_app/screens/welcome/welcome_screen.dart';

part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.WELCOME, page: () => WelcomeScreen()),
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
    GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
    GetPage(name: Routes.SIGNUP, page: () => SignupScreen()),
    GetPage(name: Routes.GAME, page: () => GameScreen()),
  ];
}
