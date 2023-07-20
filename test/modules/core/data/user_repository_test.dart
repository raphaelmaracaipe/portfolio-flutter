import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_client.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository_impl.dart';

import '../../uiauth/bloc/uiauth_bloc_test.mocks.dart';

class MockRestClient extends Mock implements RestClient {}

@GenerateMocks([MockRestClient])
void main() {
  final MockMockRestClient mockRestClient = MockMockRestClient();

  test('when send to request code with success', () async {
    when(mockRestClient.requestCode(any)).thenAnswer((_) async => {});

    UserRepository userRepository = UserRepositoryImpl(
      restClient: mockRestClient,
    );

    try {
      RequestUserCode requestUserCode = RequestUserCode(phone: "1234567890");
      await userRepository.requestCode(requestUserCode);
      expect(true, true);
    } catch (e) {
      expect(false, true);
    }
  });

  test('when send to request code with fail', () async {
    when(mockRestClient.requestCode(any)).thenThrow(
      HttpException.putEnum(
        HttpErrorEnum.ERROR_GENERAL,
      ),
    );

    UserRepository userRepository = UserRepositoryImpl(
      restClient: mockRestClient,
    );

    try {
      RequestUserCode requestUserCode = RequestUserCode(phone: "1234567890");
      await userRepository.requestCode(requestUserCode);
      expect(false, true);
    } on HttpException catch (e) {
      expect(e.enumError, HttpErrorEnum.ERROR_GENERAL);
    }
  });

  test('when send code to validation api return success', () async {
    when(
      mockRestClient.requestValidCode(any),
    ).thenAnswer(
      (_) async => ResponseValidCode(accessToken: "AAA", refreshToken: "BBB"),
    );

    UserRepository userRepository = UserRepositoryImpl(
      restClient: mockRestClient,
    );

    try {
      ResponseValidCode response = await userRepository.requestValidCode("1");
      expect("AAA", response.accessToken);
      expect("BBB", response.refreshToken);
    } catch (_) {
      expect(false, true);
    }
  });

  test('when send code to validation api return error', () async {
    when(
      mockRestClient.requestValidCode(any),
    ).thenThrow(
      HttpException.putEnum(
        HttpErrorEnum.ERROR_GENERAL,
      ),
    );

    UserRepository userRepository = UserRepositoryImpl(
      restClient: mockRestClient,
    );

    try {
      await userRepository.requestValidCode("1");
      expect(false, true);
    } on HttpException catch (e) {
      expect(e.enumError, HttpErrorEnum.ERROR_GENERAL);
    }
  });
}
