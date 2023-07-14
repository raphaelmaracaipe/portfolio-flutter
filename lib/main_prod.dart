import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/app.dart';
import 'package:portfolio_flutter/config/env.dart';

void main() {
  BuildEnvironment.init(
    flavor: BuildFlavor.producation,
    baseUrl: "http://10.0.2.2:3001",
  );

  assert(env != null);

  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
