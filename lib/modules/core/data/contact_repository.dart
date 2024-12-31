import 'dart:async';

import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';

abstract class ContactRepository {
  void checkStatus({required String phoneNumber});

  FutureOr<void> onIsHeOnline({
    required String phoneNumber,
    required Function callback,
  });

  void onIAmOnline({required String phoneNumber});

  FutureOr<bool> connect();

  void disconnect();

  FutureOr<List<ContactEntity>> consult();

  FutureOr<List<ContactEntity>> consultOffline();

  FutureOr<ContactEntity> getContactByPhone(String phone);
}
