import 'package:flutter/material.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';

class ColorsUImpl extends ColorsU {
  @override
  Color checkColorsWhichIsDarkMode({
    required BuildContext context,
    required Color light,
    required Color dark,
  }) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    if (isDarkMode) {
      return dark;
    } else {
      return light;
    }
  }
}
