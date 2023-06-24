import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/core/core_module.dart';

import 'modules/uiauth/uiauth_pages.dart';

void main() {
  return runApp(ModularApp(module: CoreModule(), child: const AppWidget()));
}

// MARK: AAAA
class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: UiAuthPage(),
      supportedLocales: const [
        Locale("pt", "BR")
      ],
      initialRoute: Modular.initialRoute,
    );
  }
}
