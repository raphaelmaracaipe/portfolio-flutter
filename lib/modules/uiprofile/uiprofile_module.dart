import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/uiprofile/uiprofile_page.dart';

class UiProfileModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const UiProfilePage(),
          transition: TransitionType.rightToLeft,
        )
      ];
}
