import 'package:flutter/material.dart';

class AppColors {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return black;
    }
    return blackOpacityColor;
  }

  Color get transparent => const Color(0x00FFFFFF);
  Color get mainAppColor => const Color(0xFF323C48);
  Color get mainAppColor60 => const Color(0x99323C48);
  Color get appSecondaryColor => const Color(0xFFD9D9D9);
  Color get barrierColor => transparent;
  Color get black => const Color(0xFF000000);
  Color get whiteColor => const Color(0xFFFFFFFF);
  Color get whisperColor => const Color(0xFFEAEAEA);
  Color get black45Color => const Color(0x73000000);
  Color get yellowColor => const Color(0xFFFFD442);
  Color get borderColor => const Color(0xFFC6C6C6);
  Color get gradientWheitrColor => const Color(0x00000000);
  Color get gradientBlackColor => const Color(0x99000000);
  Color get inputTextfieldColor => const Color(0xFFF1F2F6);
  Color get blackOpacityColor => const Color(0xFF333333);
  Color get whisperBorderColor => const Color(0xFFD8DADC);
  Color get customButtonBorderColor => const Color(0xFFE2E2E2);
  Color get lableColor => const Color(0xFF676767);
  Color get lableOpacityColor => const Color(0xFF737984);
  Color get errorColor => const Color(0xFFEF523E);
  Color get errorTextColor => const Color(0xFFFF3A3A);
  Color get suffixsColor => const Color(0xFF858585);
  Color get drawerTouchColor => const Color(0xFFBABABA);
  Color get privacyColor => const Color(0xFFB8B8B8);
  Color get popupbBorderColor => const Color(0xFFCBCBCB);
  Color get waitListScaffoldColor => const Color(0xFF60747D);
  Color get shadowColor => black.withOpacity(.04);
  Color get bookRegularColor => const Color(0xFFCBCDD2);
  Color get canBeSelectedColor => const Color(0xFCFFF4D0);
}
