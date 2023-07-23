import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/config/app_router.dart';
import 'package:portfolio_flutter/modules/uiauth/uiauth_module.dart';
import 'package:portfolio_flutter/modules/uicountry/uicountry_module.dart';
import 'package:portfolio_flutter/modules/uiprofile/uiprofile_module.dart';
import 'package:portfolio_flutter/modules/uivalidcode/uivalid_code_module.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          AppRouter.uIAuth,
          module: UiAuthModule(),
        ),
        ModuleRoute(
          AppRouter.uICountry,
          module: UiCountryModule(),
        ),
        ModuleRoute(
          AppRouter.uIValidCode,
          module: UiValidCodeModule(),
        ),
        ModuleRoute(
          AppRouter.uIProfile,
          module: UiProfileModule(),
        ),
      ];
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(
        colorSchemeSeed: AppColors.colorPrimary,
        useMaterial3: true,
      ),
      supportedLocales: const [Locale("pt", "BR")],
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
