import 'package:portfolio_flutter/modules/core/data/network/rest_token.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart';
import 'package:portfolio_flutter/modules/core/data/token_repository.dart';

class TokenRepositoryImpl extends TokenRepository {
  final RestToken restClient;
  final TokenSP tokenSP;

  TokenRepositoryImpl({
    required this.restClient,
    required this.tokenSP,
  });
}
