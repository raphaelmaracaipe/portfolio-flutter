import 'dart:async';

import 'package:portfolio_flutter/modules/core/data/network/response/response_contact.dart';

abstract class ContactRepository {
  FutureOr<List<ResponseContact>> consult(List<String> contacts);
}
