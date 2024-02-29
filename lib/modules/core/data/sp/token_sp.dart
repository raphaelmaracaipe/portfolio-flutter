import 'package:portfolio_flutter/modules/core/data/network/response/response_token.dart';

abstract class TokenSP {
  Future<void> save(ResponseToken responseValidCode);

  Future<ResponseToken> get();
}
