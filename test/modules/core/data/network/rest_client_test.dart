import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_client.dart';

void main() {
  Dio? dio;
  RestClient? restClient;
  late DioAdapter mockAdapter;

  setUp(() {
    dio = Dio();
    dio?.interceptors.add(LogInterceptor());

    mockAdapter = DioAdapter(dio: dio!);
    dio?.httpClientAdapter = mockAdapter;

    restClient = RestClient(dio!, baseUrl: '');
  });
  group('rest_client', () {
    test('when request code but api return success', () async {
      mockAdapter.onPost('/v1/users/code', (server) {
        server.reply(200, "");
      }, data: Matchers.any);

      try {
        final requestUserCode = RequestUserCode(phone: '1234567890');
        await restClient?.requestCode(requestUserCode);
        expect(true, true);
      } catch (e) {
        expect(true, false);
      }
    });

    test('when request code but api return error', () async {
      mockAdapter.onPost('/v1/users/code', (server) {
        server.reply(403, "");
      }, data: Matchers.any);

      try {
        final requestUserCode = RequestUserCode(phone: '1234567890');
        await restClient?.requestCode(requestUserCode);
        expect(true, false);
      } catch (e) {
        expect(true, true);
      }
    });

    test('when send code to validation and api return success', () async {
      ResponseValidCode responseValidCode = ResponseValidCode(
        refreshToken: "AAA",
        accessToken: "BBB",
      );

      mockAdapter.onGet('/v1/users/valid', (server) {
        server.reply(200, responseValidCode.toJson());
      });

      try {
        ResponseValidCode? response = await restClient?.requestValidCode("1");
        expect(responseValidCode.refreshToken, response?.refreshToken);
      } catch (_) {
        expect(false, true);
      }
    });

    test('when send code to validation and api return fail', () async {
      Map<String, dynamic> messageError = {
        "message": HttpErrorEnum.USER_SEND_CODE_INVALID.code,
      };

      mockAdapter.onGet('/v1/users/valid', (server) {
        server.reply(401, messageError);
      });

      try {
        await restClient?.requestValidCode("1");
        expect(false, true);
      } on DioException catch (exception) {
        final HttpException httpException = HttpException(exception);
        expect(httpException.enumError, HttpErrorEnum.USER_SEND_CODE_INVALID);
      }
    });
  });

  tearDown(() {
    dio?.close();
  });
}
