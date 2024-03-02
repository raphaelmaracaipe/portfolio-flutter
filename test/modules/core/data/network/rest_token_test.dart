import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_token.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_token.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_token.dart';
import 'package:portfolio_flutter/modules/core/utils/strings.dart';
import 'package:portfolio_flutter/modules/core/utils/strings_impl.dart';

void main() {
  Dio? dio;
  RestToken? restToken;
  late DioAdapter mockAdapter;
  Strings strings = StringsImpl();

  setUp(() {
    dio = Dio();
    dio?.interceptors.add(LogInterceptor());

    mockAdapter = DioAdapter(dio: dio!);
    dio?.httpClientAdapter = mockAdapter;

    restToken = RestToken(dio!, baseUrl: '');
  });

  test('when make request to update your token and return success', () async {
    ResponseToken responseToken = ResponseToken(
      refreshToken: strings.generateRandomString(20),
      accessToken: strings.generateRandomString(20),
    );

    mockAdapter.onPost('/v1/tokens/refresh', (server) {
      server.reply(200, responseToken.toJson());
    }, data: Matchers.any);

    try {
      final request = RequestToken(refresh: strings.generateRandomString(20));
      ResponseToken? response = await restToken?.updateToken(request);
      expect(responseToken.accessToken, response?.accessToken);
    } on DioException catch (_) {
      expect(false, true);
    }
  });

  test('when make request to update your token and return fail', () async {
    Map<String, dynamic> messageError = {
      "message": HttpErrorEnum.TOKEN_INVALID.code,
    };

    mockAdapter.onPost('/v1/tokens/refresh', (server) {
      server.reply(403, messageError);
    }, data: Matchers.any);

    try {
      final request = RequestToken(refresh: strings.generateRandomString(20));
      await restToken?.updateToken(request);
      expect(false, true);
    } on DioException catch (exception) {
      HttpException httpException = HttpException(exception: exception);
      expect(HttpErrorEnum.TOKEN_INVALID, httpException.enumError);
    }
  });

  tearDown(() {
    dio?.close();
  });
}
