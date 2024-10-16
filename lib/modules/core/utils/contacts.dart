import 'package:flutter_contacts/flutter_contacts.dart';

abstract class Contacts {
  Future<bool> requestPermission({
    bool readonly = false,
  });

  Future<List<Contact>> getContacts({
    bool withProperties = false,
    bool withThumbnail = false,
    bool withPhoto = false,
    bool withGroups = false,
    bool withAccounts = false,
    bool sorted = true,
    bool deduplicateProperties = true,
  });
}
