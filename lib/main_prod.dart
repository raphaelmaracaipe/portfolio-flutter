import 'package:flutter/cupertino.dart';
import 'package:portfolio_flutter/app.dart';
import 'package:portfolio_flutter/config/app_api.dart';
import 'package:portfolio_flutter/config/app_firebase.dart';
import 'package:portfolio_flutter/config/env.dart';
import 'package:portfolio_flutter/di/getIt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppFirebase.configFirebase();

  BuildEnvironment.init(
    flavor: BuildFlavor.producation,
    baseUrl: AppApi.baseURL,
  );

  assert(env != null);

  configureDependencies();
  return runApp(AppWidget());
}
