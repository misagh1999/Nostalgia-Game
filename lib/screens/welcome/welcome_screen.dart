import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), goToNextScreen);
    return Scaffold(
      body: Center(child: Text('بازی گل یا پوچ')),
    );
  }

  goToNextScreen() {
    Get.offAndToNamed(Routes.LOGIN);
  }
}
