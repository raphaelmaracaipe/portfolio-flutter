import 'package:flutter/material.dart';
import 'package:portfolio_flutter/app.dart';
import 'package:portfolio_flutter/config/app_api.dart';
import 'package:portfolio_flutter/config/env.dart';
import 'package:portfolio_flutter/di/getIt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BuildEnvironment.init(
    flavor: BuildFlavor.development,
    baseUrl: AppApi.baseURL,
  );

  assert(env != null);

  configureDependencies();
  return runApp(AppWidget());
}
