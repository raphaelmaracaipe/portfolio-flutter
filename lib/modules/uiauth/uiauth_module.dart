import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/core/core_module.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc.dart';
import 'package:portfolio_flutter/modules/uiauth/uiauth_pages.dart';

class UiAuthModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<Bind> get binds => [
        Bind.factory<UiAuthBloc>(
          (i) => UiAuthBloc(
            countriesRepository: i(),
            userRepository: i(),
            routeRepository: i(),
          ),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const UiAuthPage(),
          transition: TransitionType.rightToLeft,
        ),
      ];
}
