import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import 'modules/uiauth/uiauth_pages.dart';

void main() {
  LocalJsonLocalization.delegate.directories = ['assets/lang'];
  return runApp(MaterialApp(
    localeResolutionCallback: (locale, supportedLocales) {
      return locale;
    },
    localizationsDelegates: [
      LocalJsonLocalization.delegate,
    ],
    theme: ThemeData(
      useMaterial3: true,
    ),
    home: const UiAuthPage(),
  ));
}
