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
import 'package:portfolio_flutter/modules/core/data/socket/socket_config.dart';
import 'package:portfolio_flutter/modules/core/utils/contacts.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

@Injectable(as: ContactRepository)
class ContactRepositoryImpl extends ContactRepository {
  final RestContact restContact;
  final Contacts contacts;
  final ContactDao contactDao;
  final SocketConfig socketConfig;
  late Logger logger;
  late io.Socket? socket;

  ContactRepositoryImpl({
    required this.restContact,
    required this.contacts,
    required this.contactDao,
    required this.socketConfig,
  }) {
    logger = Logger();
    socket = socketConfig.config();
  }

  @override
  FutureOr<bool> connect() async {
    final completer = Completer<bool>();
    socket?.connect();
    socket?.onConnect(
      (_) => {
        logger.i("socket is connected"),
        completer.complete(true),
      },
    );
    return completer.future;
  }

  @override
  void disconnect() {
    socket?.onDisconnect(
      (_) => {
        logger.w("socket is disconnected"),
      },
    );
    socket?.disconnect();
  }

  @override
  void checkStatus({required String phoneNumber}) {
    if (socket?.connected ?? false) {
      socket?.emit('checkStatus', phoneNumber);
    } else {
      logger.w("Socket not connected");
    }
  }

  @override
  FutureOr<void> onIsHeOnline({
    required String phoneNumber,
    required Function callback,
  }) {
    final completer = Completer<void>();
    socket?.on(
      'isHeOnline$phoneNumber',
      (_) async {
        logger.i("Is he online $phoneNumber");
        try {
          await contactDao.updateLastOnline(
            DateTime.now().millisecondsSinceEpoch.toString(),
            phoneNumber,
          );

          callback();
        } on Exception catch (e) {
          logger.e("Error in onIsHeOnline", error: e);
        }
        completer.complete();
      },
    );
    return completer.future;
  }

  @override
  void onIAmOnline({
    required String phoneNumber,
  }) {
    socket?.on('status$phoneNumber', (_) {
      socket?.emit('iAmOnline', phoneNumber);
    });
  }

  @override
  FutureOr<List<ContactEntity>> consultOffline() async =>
      await contactDao.getAll() ?? [];

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
      if (contact.phone == null) {
        return;
      }

      final phone = contact.phone ?? "";
      final photo = contact.photo ?? "";
      final name = contact.name ?? "";

      if ((await contactDao.countUsePhone(phone) ?? 0) > 0) {
        await contactDao.updatePhoto(photo, phone);
        return;
      }

      await contactDao.insert(ContactEntity(
        photo: photo,
        phone: phone,
        name: name,
      ));
    }
  }

  @override
  FutureOr<ContactEntity> getContactByPhone(String phone) async {
    return await contactDao.getContactByPhone(phone) ??
        ContactEntity(
          phone: phone,
        );
  }
}
