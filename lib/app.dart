import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter/routers/app_router.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = GetIt.instance();
    _initFirebase();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(
        colorSchemeSeed: AppColors.colorPrimary,
        useMaterial3: true,
      ),
      supportedLocales: const [Locale("pt", "BR")],
      routerConfig: appRouter.config(),
    );
  }

  Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
