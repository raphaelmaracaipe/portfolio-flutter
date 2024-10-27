import 'dart:async';

import 'package:floor/floor.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';

@dao
abstract class ContactDao {
  @Query('SELECT COUNT(*) FROM ContactEntity')
  Future<int?> count();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(ContactEntity contact);

  @Query("SELECT * FROM ContactEntity")
  Future<List<ContactEntity>?> getAll();
}
