import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_token.dart';
import 'package:portfolio_flutter/modules/core/data/token_interceptor_repository.dart';

class DioErrorInterceptor extends Interceptor {
  final TokenInterceptorRepository tokenInterceptorRepository;
  final Dio dio;
  final Logger logger = Logger();

  DioErrorInterceptor({
    required this.tokenInterceptorRepository,
    required this.dio,
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final Map<String, dynamic> responseData = err.response?.data ?? Map.of({});
    if (responseData["statusCode"] == 401 &&
        responseData["message"] == HttpErrorEnum.TOKEN_INVALID.code) {
      ResponseToken newTokens = await tokenInterceptorRepository.updateToken();

      String accessToken = newTokens.accessToken ?? "";
      if (accessToken.isNotEmpty) {
        err.requestOptions.headers["Authorization"] = 'Bearer $accessToken';
        return handler.resolve(await dio.fetch(err.requestOptions));
      }
    }

    return handler.next(err);
  }
}
