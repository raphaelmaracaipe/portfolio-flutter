// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:portfolio_flutter/config/app_database_config.dart';
import 'package:portfolio_flutter/modules/core/data/db/daos/contact_dao.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';

part 'app_database.g.dart';

@Database(version: AppDatabaseConfig.version, entities: [ContactEntity])
abstract class AppDatabase extends FloorDatabase {
  ContactDao get contactDao;
}
