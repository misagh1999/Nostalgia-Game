import 'package:get/get.dart';
import 'package:handy_dandy_app/logic/hand_rock_rule.dart';

class HandRockController extends GetxController {
  RxInt restTurn = 5.obs;

  RxInt yourLive = 3.obs;
  RxInt rivalLive = 3.obs;

  Rx<RivalStatus> rivalStatus = RivalStatus.idle.obs;

  Rx<OptionType> yourOptionType = OptionType.nothing.obs;
  Rx<OptionType> rivalOptionType = OptionType.nothing.obs;

  RxString get rivalStatusStr {
    var result = "";
    if (rivalStatus.value == RivalStatus.isSelecting)
      result = "حریف شما در حال انتخاب است";
    else if (rivalStatus.value == RivalStatus.selected)
      result = "حریف شما انتخاب کرد";

    return result.obs;
  }

  @override
  void onInit() {
    _retry();
    super.onInit();
  }

  onChooseButton(OptionType optionType) {
    yourOptionType.value = optionType;
    if (rivalStatus.value == RivalStatus.selected) {
      // todo:
    }
  }

  _selectMachine() {
    // select machine
  }

  _retry() {
    yourOptionType.value = OptionType.nothing;
    rivalOptionType.value = OptionType.nothing;
    rivalStatus.value = RivalStatus.idle;
  }

  _checkResult() {
    var yourOptionStr = _optionTypeToStr(yourOptionType.value);
    var rivalOptionStr = _optionTypeToStr(rivalOptionType.value);

    var isYouWin = false;
    var isRivalWin = false;

    for (var role in hand_rock_rule) {
      if (role[YOUR_OPTION] == yourOptionStr &&
          role[RIVAL_OPTION] == rivalOptionStr) {
        isYouWin = role[YOUR_WIN] as bool;
        isRivalWin = role[RIVAL_WIN] as bool;
      }
    }
    if (!isYouWin) {
      yourLive.value = yourLive.value - 1;
    }
    if (!isRivalWin) {
      rivalLive.value = rivalLive.value - 1;
    }

    // check if zero or finish restTurn
  }

  _optionTypeToStr(OptionType optionType) {
    var result = "";
    switch (optionType) {
      case OptionType.hand:
        result = PAPER;
        break;
      case OptionType.scisors:
        result = SCISSORS;
        break;
      case OptionType.rock:
        result = ROCK;
        break;
      default:
    }
    return result;
  }
}

enum RivalStatus { idle, isSelecting, selected }

enum OptionType { nothing, hand, rock, scisors }
