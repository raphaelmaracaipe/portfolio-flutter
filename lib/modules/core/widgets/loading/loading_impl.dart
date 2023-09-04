import 'package:flutter/material.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading_widget.dart';

class LoadingImpl implements Loading {
  @override
  Widget showLoading(AppLocalization localization) => LoadingWidget(
        appLocalization: localization,
      );
}
