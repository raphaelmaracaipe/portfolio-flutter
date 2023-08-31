import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/app.dart';
import 'package:portfolio_flutter/config/env.dart';
import 'package:portfolio_flutter/di/getIt.dart';

import 'routers/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BuildEnvironment.init(
    flavor: BuildFlavor.development,
    baseUrl: "http://10.0.2.2:3000/api",
  );

  assert(env != null);

  configureDependencies();
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}