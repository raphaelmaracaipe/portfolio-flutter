import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_profile.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_profile.dart';
import 'package:portfolio_flutter/modules/core/utils/strings_impl.dart';
import 'package:portfolio_flutter/modules/core/utils/strings.dart';

void main() {
  Dio? dio;
  RestProfile? restProfile;
  late DioAdapter mockAdapter;
  Strings string = StringsImpl();

  setUp(() {
    dio = Dio();
    dio?.interceptors.add(LogInterceptor());

    mockAdapter = DioAdapter(dio: dio!);
    dio?.httpClientAdapter = mockAdapter;

    restProfile = RestProfile(dio!, baseUrl: '');
  });

  test('when request return error generic', () async {
    mockAdapter.onPost('/v1/users/profile', (server) {
      server.reply(403, "");
    }, data: Matchers.any);

    try {
      final requestProfile = RequestProfile(
        name: string.generateRandomString(5),
        photo: string.generateRandomString(40),
      );

      await restProfile?.requestProfile(requestProfile);
      expect(true, false);
    } on Exception {
      expect(true, true);
    }
  });

  test('when request return error profile', () async {
    Map<String, dynamic> messageError = {
      "message": HttpErrorEnum.USER_SEND_CODE_INVALID.code
    };

    mockAdapter.onPost('/v1/users/profile', (server) {
      server.reply(403, messageError);
    }, data: Matchers.any);

    try {
      final requestProfile = RequestProfile(
        name: string.generateRandomString(5),
        photo: string.generateRandomString(40),
      );

      await restProfile?.requestProfile(requestProfile);
      expect(true, false);
    } on DioException catch (exception) {
      final HttpException httpException = HttpException(exception: exception);
      expect(HttpErrorEnum.USER_SEND_CODE_INVALID, httpException.enumError);
    }
  });

  tearDown(() {
    dio?.close();
  });
}
