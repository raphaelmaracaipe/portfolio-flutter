import 'dart:async';

import 'package:floor/floor.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';

@dao
abstract class ContactDao {
  @Query('SELECT COUNT(*) FROM ContactEntity')
  Future<int?> count();

  @Query('SELECT COUNT(*) FROM ContactEntity WHERE phone = :phone')
  Future<int?> countUsePhone(String phone);

  @Insert()
  Future<void> insert(ContactEntity contact);

  @Query("SELECT * FROM ContactEntity")
  Future<List<ContactEntity>?> getAll();

  @Query(
    "UPDATE ContactEntity SET lastOnline = :lastOnline  WHERE phone = :phone",
  )
  Future<void> updateLastOnline(String lastOnline, String phone);

  @Query("UPDATE ContactEntity SET photo = :photo WHERE phone = :phone")
  Future<void> updatePhoto(String photo, String phone);

  @Query("SELECT * FROM ContactEntity WHERE phone = :phone")
  Future<ContactEntity?> getContactByPhone(String phone);
}
