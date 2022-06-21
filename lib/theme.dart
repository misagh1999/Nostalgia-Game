import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
      fontFamily: Fonts.Regular,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: secondaryColor, primary: primaryColor));
}
