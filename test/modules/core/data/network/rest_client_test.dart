import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_client.dart';

void main() {
  Dio? dio;
  RestClient? restClient;

  setUp(() {
    dio = Dio();
    dio?.interceptors.add(LogInterceptor());
    restClient = RestClient(dio!, baseUrl: '');
  });
  group('rest_client', () {
    test('when request code but api return success', () async {
      final mockAdapter = DioAdapter(dio: dio!);
      dio?.httpClientAdapter = mockAdapter;

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
      final mockAdapter = DioAdapter(dio: dio!);
      dio?.httpClientAdapter = mockAdapter;

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
  });

  tearDown(() {
    dio?.close();
  });
}
