import 'dart:async';

import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';

abstract class ContactRepository {
  FutureOr<List<ContactEntity>> consult();
  FutureOr<List<ContactEntity>> consultOffline();
}
