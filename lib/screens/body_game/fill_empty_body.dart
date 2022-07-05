import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:handy_dandy_app/controllers/fill_empty_controller.dart';

import '../../constants.dart';
import '../online_game/main/components/online_box_widget.dart';

class FillEmptyBody extends StatelessWidget {
  FillEmptyBody({
    Key? key,
  }) : super(key: key);

  final FillEmptyController controller = Get.put(FillEmptyController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.messageTitle.value,
                style: TextStyle(fontFamily: Fonts.Medium),
              ),
              SizedBox(
                width: 4,
              ),
              controller.isSelectingRival.value
                  ? SpinKitCircle(
                      color: primaryColor,
                      size: 20,
                    )
                  : SizedBox()
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              OnlineBoxWidget(boxNumber: 1),
              SizedBox(
                width: 12,
              ),
              OnlineBoxWidget(boxNumber: 2),
            ],
          ),
        ],
      ),
    );
  }
}
