import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_contact.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_contact.dart';

void main() {
  Dio? dio;
  RestContact? restContact;
  late DioAdapter mockAdapter;

  setUp(() {
    dio = Dio();
    dio?.interceptors.add(LogInterceptor());

    mockAdapter = DioAdapter(dio: dio!);
    dio?.httpClientAdapter = mockAdapter;

    restContact = RestContact(dio!, baseUrl: '');
  });

  test('when consult contact should return list', () async {
    List<Map<String, dynamic>> mockResponse = [
      {
        "name": "test n 01",
        "phone": "test p 01",
        "photo": "test n 02",
      }
    ];

    mockAdapter.onPost('/v1/contacts', (server) {
      server.reply(200, mockResponse);
    }, data: Matchers.any);

    try {
      final List<String> contacts = ["555", "444"];
      List<ResponseContact>? returnConsult = await restContact?.consult(
        contacts,
      );

      expect("test n 01", returnConsult?[0].name);
    } on Exception {
      expect(true, false);
    }
  });

  tearDown(() {
    dio?.close();
  });
}
