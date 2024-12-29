// ignore_for_file: file_names

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_flutter/config/app_database_config.dart';
import 'package:portfolio_flutter/modules/core/data/db/app_database.dart';
import 'package:portfolio_flutter/modules/core/data/db/daos/contact_dao.dart';

import 'getIt.config.dart';

final getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
void configureDependencies() {
  getIt.init();

  getIt.registerSingletonAsync<AppDatabase>(() => $FloorAppDatabase
      .databaseBuilder(
        AppDatabaseConfig.name,
      )
      .build());

  getIt.registerSingletonWithDependencies<ContactDao>(
    () => getIt<AppDatabase>().contactDao,
    dependsOn: [AppDatabase],
  );
}
