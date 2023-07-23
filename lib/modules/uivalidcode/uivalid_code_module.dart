import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/core/core_module.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc.dart';
import 'package:portfolio_flutter/modules/uivalidcode/uivalid_code_pages.dart';

class UiValidCodeModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<Bind> get binds => [
        Bind.factory<UiValidCodeBloc>(
          (i) => UiValidCodeBloc(
            userRepository: i(),
          ),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const UiValidCodePages(),
          transition: TransitionType.rightToLeft,
        )
      ];
}
