import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_hand_shake.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_hand_shake.dart';

void main() {
  late DioAdapter mockAdapter;

  Dio? dio;
  RestHandShake? restHandShake;

  setUp(() {
    dio = Dio();
    dio?.interceptors.add(LogInterceptor());

    mockAdapter = DioAdapter(dio: dio!);
    dio?.httpClientAdapter = mockAdapter;

    restHandShake = RestHandShake(dio!, baseUrl: '');
  });

  test('when request of handshake and api return success', () async {
    mockAdapter.onPost('/v1/handshake/', (server) {
      server.reply(200, "");
    }, data: Matchers.any);

    try {
      final requestHandShake = RequestHandShake(key: "1");
      await restHandShake?.requestHandShake(requestHandShake);
      expect(true, true);
    } catch (e) {
      expect(true, false);
    }
  });

  test('when request of handshake and api return fail', () async {
    Map<String, dynamic> messageError = {
      "message": HttpErrorEnum.USER_SEND_CODE_INVALID.code,
    };

    mockAdapter.onPost('/v1/handshake/', (server) {
      server.reply(403, messageError);
    }, data: Matchers.any);

    try {
      final requestHandShake = RequestHandShake(key: "1");
      await restHandShake?.requestHandShake(requestHandShake);
      expect(true, false);
    } on DioException catch (exception) {
      final HttpException httpException = HttpException(exception);
      expect(httpException.enumError, HttpErrorEnum.USER_SEND_CODE_INVALID);
    }
  });

  tearDown(() {
    dio?.close();
  });

}