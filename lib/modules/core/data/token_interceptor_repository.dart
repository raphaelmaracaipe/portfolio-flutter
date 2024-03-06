import 'package:portfolio_flutter/modules/core/data/network/response/response_token.dart';

abstract class TokenInterceptorRepository {
  Future<ResponseToken> updateToken();
}
