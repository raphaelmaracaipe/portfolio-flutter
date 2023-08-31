import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_flutter/routers/app_router.dart';
import 'getIt.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
void configureDependencies() => getIt.init();