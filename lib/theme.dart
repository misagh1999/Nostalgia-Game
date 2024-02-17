import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
      fontFamily: Fonts.Regular,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: secondaryColor, primary: primaryColor));
}
