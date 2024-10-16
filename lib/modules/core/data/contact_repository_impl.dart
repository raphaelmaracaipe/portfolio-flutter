import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_flutter/modules/core/data/contact_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/permission_not_granted.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_contact.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_contact.dart';
import 'package:portfolio_flutter/modules/core/regex/regex.dart';
import 'package:portfolio_flutter/modules/core/utils/contacts.dart';

@Injectable(as: ContactRepository)
class ContactRepositoryImpl extends ContactRepository {
  final RestContact restContact;
  final Contacts contacts;

  ContactRepositoryImpl({
    required this.restContact,
    required this.contacts,
  });

  @override
  FutureOr<List<ResponseContact>> consult(List<String> contacts) async {
    final listOfNumbers = await _fetchContacts();
    if (listOfNumbers == null) {
      throw PermissionNotGranted();
    }

    try {
      return await restContact.consult(listOfNumbers);
    } on DioException catch (e) {
      throw HttpException(exception: e);
    } on Exception catch (_) {
      throw HttpException(errorEnum: HttpErrorEnum.ERROR_GENERAL);
    }
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
}
