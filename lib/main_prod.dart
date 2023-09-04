import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/app.dart';
import 'package:portfolio_flutter/config/app_firebase.dart';
import 'package:portfolio_flutter/config/env.dart';
import 'package:portfolio_flutter/di/getIt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppFirebase.configFirebase();

  BuildEnvironment.init(
    flavor: BuildFlavor.producation,
    baseUrl: "http://10.0.2.2:3001/api",
  );

  assert(env != null);

  configureDependencies();
  return runApp(const AppWidget());
}
