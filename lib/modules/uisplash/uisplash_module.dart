import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/core/core_module.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc.dart';

import 'uisplash_page.dart';

class UiSplashModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<Bind<Object>> get binds => [
        Bind.factory<UiSplashBloc>(
          (i) => UiSplashBloc(
            routeRepository: i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => UiSplashPage(),
        ),
      ];
}
