import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/core/test/test.dart';
import 'package:portfolio_flutter/modules/core/test/test_impl.dart';
import 'package:portfolio_flutter/modules/uiauth/uiauth_pages.dart';

class UiAuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<Test>((i) => TestImpl()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const UiAuthPage()),
      ];
}
