import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/core/core_module.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc.dart';
import 'package:portfolio_flutter/modules/uicountry/uicountry_page.dart';

class UiCountryModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<Bind<Object>> get binds => [
        Bind.factory<UICountryBloc>(
          (i) => UICountryBloc(
            countriesRepository: i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) {
            return UiCountryPage();
          },
          transition: TransitionType.rightToLeft,
        )
      ];
}
