import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_token.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_token.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_token.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart';
import 'package:portfolio_flutter/modules/core/data/token_interceptor_repository.dart';

class TokenInterceptorRepositoryImpl extends TokenInterceptorRepository {
  final RestToken restToken;
  final TokenSP tokenSP;

  TokenInterceptorRepositoryImpl({
    required this.restToken,
    required this.tokenSP,
  });

  @override
  Future<ResponseToken> updateToken() async {
    try {
      final tokensSaved = await tokenSP.get();
      final returnRequest = await restToken.updateToken(
        RequestToken(refresh: tokensSaved.refreshToken),
      );

      await tokenSP.save(returnRequest);
      return returnRequest;
    } on DioException catch (e) {
      throw HttpException(exception: e);
    } on Exception catch (_) {
      throw HttpException(errorEnum: HttpErrorEnum.ERROR_GENERAL);
    }
  }
}
