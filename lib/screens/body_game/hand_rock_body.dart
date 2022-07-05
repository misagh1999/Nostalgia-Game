import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controllers/hand_rock_controller.dart';

class HandRockBody extends StatelessWidget {
  HandRockBody({
    Key? key,
  }) : super(key: key);

  final HandRockController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
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
          SizedBox(
            height: 12,
          ),
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
        ],
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
