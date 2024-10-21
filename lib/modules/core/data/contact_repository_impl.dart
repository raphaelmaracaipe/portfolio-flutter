import 'dart:async';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/modules/core/data/contact_repository.dart';
import 'package:portfolio_flutter/modules/core/data/db/daos/contact_dao.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/permission_not_granted.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_contact.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_contact.dart';
import 'package:portfolio_flutter/modules/core/utils/contacts.dart';

@Injectable(as: ContactRepository)
class ContactRepositoryImpl extends ContactRepository {
  final RestContact restContact;
  final Contacts contacts;
  final ContactDao contactDao;
  late Logger logger;

  ContactRepositoryImpl({
    required this.restContact,
    required this.contacts,
    required this.contactDao,
  }) {
    logger = Logger();
  }

  @override
  FutureOr<List<ContactEntity>> consultOffline() async => await contactDao.getAll() ?? [];

  @override
  FutureOr<List<ContactEntity>> consult() async {
    try {
      final listOfNumbers = await _fetchContacts();
      if (listOfNumbers == null) {
        throw PermissionNotGranted();
      }

      final contactsConsulted = await restContact.consult(listOfNumbers);
      await _salveInDb(contactsConsulted);
    } on Exception catch (e) {
      logger.e("Error to generic", error: e);
    }

    return await contactDao.getAll() ?? [];
  }

  FutureOr<List<String>?> _fetchContacts() async {
    if (await contacts.requestPermission()) {
      List<Contact> listOfContacts = await contacts.getContacts(
        withProperties: true,
      );

      final List<String> numbersOfContacts = listOfContacts
          .expand(
            (contact) => contact.phones.map((phone) {
              return phone.number.replaceAll(RegExp(r'[^\d]'), '');
            }),
          )
          .toList();

      return numbersOfContacts;
    } else {
      return null;
    }
  }

  Future<void> _salveInDb(List<ResponseContact> contactsConsulted) async {
    for (var contact in contactsConsulted) {
      await contactDao.insert(ContactEntity(
        photo: contact.photo,
        phone: contact.phone,
        name: contact.name,
      ));
    }
  }
}
