import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/hand_rock_controller.dart';
import 'package:handy_dandy_app/widgets/app_bar.dart';

import '../../../constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/rest_live_widget.dart';

class HandRockMainScreen extends StatelessWidget {
  HandRockMainScreen({Key? key}) : super(key: key);

  final HandRockController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMyAppBar(title: 'سنگ کاغذ قیچی'),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text('نوبت باقی مانده'),
              Text(
                replacePersianNum('5'),
                style: TextStyle(fontFamily: Fonts.Bold, fontSize: 18),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                      child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('شما'),
                        RestLiveWidget(restLive: controller.yourLive.value)
                      ],
                    ),
                  )),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(' حریف'),
                        RestLiveWidget(restLive: controller.rivalLive.value)
                      ],
                    ),
                  ))
                ],
              ),
              Spacer(),
              Text(controller.rivalStatusStr.value),
              SizedBox(
                height: 12,
              ),
              Container(
                width: Get.width / 3,
                height: Get.width / 3,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: FaIcon(
                  FontAwesomeIcons.search,
                  size: Get.width / 6,
                )),
              ),
              Spacer(),
              Text('گزینه خود را انتخاب کنید'),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  _buildOptionsWidget(
                      icon: FontAwesomeIcons.hand,
                      onPress: () {
                        controller.onChooseButton(OptionType.hand);
                      }),
                  Spacer(),
                  _buildOptionsWidget(
                      icon: FontAwesomeIcons.handScissors,
                      onPress: () {
                        controller.onChooseButton(OptionType.scisors);
                      }),
                  Spacer(),
                  _buildOptionsWidget(
                      icon: FontAwesomeIcons.handBackFist,
                      onPress: () {
                        controller.onChooseButton(OptionType.rock);
                      }),
                ],
              ),
              Spacer(
                flex: 3,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsWidget(
      {required IconData icon, required VoidCallback onPress}) {
    return Container(
      width: Get.width / 4,
      height: Get.width / 4,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)),
      child: Center(
          child: FaIcon(
        icon,
        size: Get.width / 7,
      )),
    );
  }
}
