import 'package:flutter/material.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';

abstract class Loading {
  Widget showLoading(
    AppLocalization localization,
    ColorsU colorsU,
  );
}
