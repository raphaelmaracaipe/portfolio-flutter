import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';

abstract class TokenSP {
  Future<void> save(ResponseValidCode responseValidCode);

  Future<ResponseValidCode> get();
}
