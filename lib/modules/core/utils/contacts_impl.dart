import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_flutter/modules/core/utils/contacts.dart';

@Injectable(as: Contacts)
class ContactsImpl extends Contacts {
  @override
  Future<bool> requestPermission({
    bool readonly = false,
  }) async =>
      await FlutterContacts.requestPermission(
        readonly: readonly,
      );

  @override
  Future<List<Contact>> getContacts({
    bool withProperties = false,
    bool withThumbnail = false,
    bool withPhoto = false,
    bool withGroups = false,
    bool withAccounts = false,
    bool sorted = true,
    bool deduplicateProperties = true,
  }) async =>
      await FlutterContacts.getContacts(
        withProperties: withProperties,
        withThumbnail: withThumbnail,
        withPhoto: withPhoto,
        withGroups: withGroups,
        withAccounts: withAccounts,
        sorted: sorted,
        deduplicateProperties: deduplicateProperties,
      );
}
