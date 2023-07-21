import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class AppLocalization {

  set context(BuildContext context);

  AppLocalizations? get localization;

}