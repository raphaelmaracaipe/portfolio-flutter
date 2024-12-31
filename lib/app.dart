import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/config/app_stream.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/routers/app_router.dart';
import 'package:portfolio_flutter/routers/app_router.gr.dart';

import 'firebase_options.dart';

class AppWidget extends StatelessWidget {
  final AppRouter _appRouter = GetIt.instance();
  final AppLocalization _appLocalizations = GetIt.instance();

  AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    _initFirebase();
    _eventLogout();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(
        colorSchemeSeed: AppColors.colorPrimary,
        useMaterial3: true,
      ),
      supportedLocales: const [Locale("pt", "BR")],
      routerConfig: _appRouter.config(),
    );
  }

  void _eventLogout() {
    AppStream.streamLogoutController = StreamController.broadcast();
    AppStream.streamLogoutController?.stream.listen((_) {
      Fluttertoast.showToast(
        msg: _appLocalizations.localization?.generalLogout ?? "",
      );
      _appRouter.replace(const UiSplashRoute());
    });
  }

  Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
