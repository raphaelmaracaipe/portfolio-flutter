import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/app.dart';
import 'package:portfolio_flutter/config/env.dart';

void main() {
  BuildEnvironment.init(
    flavor: BuildFlavor.development,
    baseUrl: "http://10.0.2.2:3000/api",
  );

  assert(env != null);

  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
