import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/uivalidcode/uivalid_code_pages.dart';

class UiValidCodeModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const UiValidCodePages(),
          transition: TransitionType.rightToLeft,
        )
      ];
}
