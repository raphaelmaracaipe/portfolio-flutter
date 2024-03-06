import 'package:flutter/material.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading_widget.dart';

class LoadingImpl implements Loading {
  @override
  Widget showLoading(
    AppLocalization localization,
    ColorsU colorsU,
  ) =>
      LoadingWidget(
        appLocalization: localization,
        colorsU: colorsU,
      );
}
