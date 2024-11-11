import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/config/app_stream.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/sp/device_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/route_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/user_sp.dart';
import 'package:portfolio_flutter/modules/core/data/token_interceptor_repository.dart';

class DioErrorInterceptor extends Interceptor {
  final Logger logger = Logger();
  final TokenInterceptorRepository tokenInterceptorRepository;
  final Dio dio;
  final DeviceSP? deviceSP;
  final KeySP? keySP;
  final UserSP? userSP;
  final RouteSP? routeSP;
  final TokenSP? tokenSP;

  DioErrorInterceptor({
    required this.tokenInterceptorRepository,
    required this.dio,
    this.deviceSP,
    this.keySP,
    this.userSP,
    this.routeSP,
    this.tokenSP,
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final Map<String, dynamic> responseData = err.response?.data ?? Map.of({});
    if (responseData["message"] == HttpErrorEnum.TOKEN_INVALID.code) {
      logger.w("Token invalid, i take new token from server");
      final newTokens = await tokenInterceptorRepository.updateToken();

      String accessToken = newTokens.accessToken ?? "";
      if (accessToken.isNotEmpty) {
        logger.i("Token updated");
        err.requestOptions.headers["Authorization"] = 'Bearer $accessToken';
        return handler.resolve(await dio.fetch(err.requestOptions));
      }

      logger.i("Fail to update token");
    } else if (responseData["message"] ==
        HttpErrorEnum.USER_INVALID_LOGIN_AGAIN.code) {
      logger.w("Device invalid, you need to login in again");
      await deviceSP?.clean();
      await keySP?.clean();
      await userSP?.clean();
      await routeSP?.clean();
      await tokenSP?.clean();

      AppStream.streamLogoutController?.add(null);
    }

    return handler.next(err);
  }
}
