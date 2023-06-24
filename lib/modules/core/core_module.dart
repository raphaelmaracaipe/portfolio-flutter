import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/core/test/test.dart';
import 'package:portfolio_flutter/modules/core/test/test_impl.dart';

class CoreModule extends Module {
  @override
  List<Bind> get binds => [Bind.factory<Test>((i) => TestImpl())];
}
