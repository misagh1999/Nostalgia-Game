import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../controllers/hand_rock_controller.dart';

class HandRockBody extends StatelessWidget {
  HandRockBody({
    Key? key,
  }) : super(key: key);

  final HandRockController controller = Get.put(HandRockController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: Column(
          children: [
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Text(
            //       controller.rivalStatusStr.value,
            //       style: TextStyle(fontFamily: Fonts.Medium),
            //     ),
            //     SizedBox(
            //       width: 4,
            //     ),
            //     controller.rivalStatus.value == RivalStatus.isSelecting
            //         ? SpinKitCircle(
            //             color: primaryColor,
            //             size: 20,
            //           )
            //         : SizedBox()
            //   ],
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // Divider(),
            Row(
              children: [
                Spacer(),
                Column(
                  children: [
                    Text('گزینه شما'),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: Get.width / 4,
                      height: Get.width / 4,
                      decoration: BoxDecoration(
                          color: controller.yourOptionColor.value,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: controller.yourStatus.value ==
                                  RivalStatus.isSelecting
                              ? SpinKitCircle(
                                  color: primaryColor,
                                  size: 36,
                                )
                              : FaIcon(
                                  controller.yourOptionIcon.value,
                                  size: Get.width / 6,
                                )),
                    )
                  ],
                ),
                Spacer(
                  flex: 2,
                ),
                Column(
                  children: [
                    Text('گزینه حریف'),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: Get.width / 4,
                      height: Get.width / 4,
                      decoration: BoxDecoration(
                          color: controller.rivalOptionColor.value,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: controller.rivalStatus.value ==
                                  RivalStatus.isSelecting
                              ? SpinKitCircle(
                                  color: primaryColor,
                                  size: 36,
                                )
                              : FaIcon(
                                  controller.rivalOptionIcon.value,
                                  size: Get.width / 6,
                                )),
                    )
                  ],
                ),
                Spacer()
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Divider(),
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
      ),
    );
  }

  Widget _buildOptionsWidget(
      {required IconData icon, required VoidCallback onPress}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
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
      ),
    );
  }
}
