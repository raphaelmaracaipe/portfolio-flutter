import 'package:flutter/widgets.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLocalizationImpl extends AppLocalization {

  late AppLocalizations? _appLocalizations;

  @override
  AppLocalizations? get localization => _appLocalizations;

  @override
  set context(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context);
  }

}
