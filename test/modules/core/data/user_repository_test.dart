import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_token.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_user.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/user_sp.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository_impl.dart';

import 'user_repository_test.mocks.dart';

class RestUserMock extends Mock implements RestUser {}

class TokenSPMock extends Mock implements TokenSP {}

class UserSPMock extends Mock implements UserSP {}

@GenerateMocks([
  RestUserMock,
  TokenSPMock,
  UserSPMock,
])
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final MockRestUserMock restUserMock = MockRestUserMock();
  final MockTokenSPMock tokenSPMock = MockTokenSPMock();
  final MockUserSPMock userSPMock = MockUserSPMock();

  test('when send to request code with success', () async {
    when(restUserMock.requestCode(any)).thenAnswer((_) async => {});

    UserRepository userRepository = UserRepositoryImpl(
      restClient: restUserMock,
      tokenSP: tokenSPMock,
      userSP: userSPMock,
    );

    try {
      RequestUserCode requestUserCode = RequestUserCode(phone: "1234567890");
      await userRepository.requestCode(requestUserCode);
      expect(true, true);
    } on Exception {
      expect(false, true);
    }
  });

  test('when send to request code with fail', () async {
    when(restUserMock.requestCode(any)).thenThrow(
      HttpException.putEnum(
        HttpErrorEnum.ERROR_GENERAL,
      ),
    );

    UserRepository userRepository = UserRepositoryImpl(
      restClient: restUserMock,
      tokenSP: tokenSPMock,
      userSP: userSPMock,
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
      restUserMock.requestValidCode(any),
    ).thenAnswer(
      (_) async => ResponseToken(accessToken: "AAA", refreshToken: "BBB"),
    );

    UserRepository userRepository = UserRepositoryImpl(
      restClient: restUserMock,
      tokenSP: tokenSPMock,
      userSP: userSPMock,
    );

    try {
      await userRepository.requestValidCode("1");
      expect(true, true);
    } on Exception catch (_) {
      expect(false, true);
    }
  });

  test('when send code to validation api return error', () async {
    when(
      restUserMock.requestValidCode(any),
    ).thenThrow(DioException(requestOptions: RequestOptions()));

    UserRepository userRepository = UserRepositoryImpl(
      restClient: restUserMock,
      tokenSP: tokenSPMock,
      userSP: userSPMock,
    );

    try {
      await userRepository.requestValidCode("1");
      expect(false, true);
    } on HttpException catch (e) {
      expect(e.enumError, HttpErrorEnum.UNKNOWN);
    }
  });

  test('when send code to validation api return error generic', () async {
    when(
      restUserMock.requestValidCode(any),
    ).thenThrow(
      HttpException.putEnum(
        HttpErrorEnum.ERROR_GENERAL,
      ),
    );

    UserRepository userRepository = UserRepositoryImpl(
      restClient: restUserMock,
      tokenSP: tokenSPMock,
      userSP: userSPMock,
    );

    try {
      await userRepository.requestValidCode("1");
      expect(false, true);
    } on HttpException catch (e) {
      expect(e.enumError, HttpErrorEnum.ERROR_GENERAL);
    }
  });

  test('when get phone saved', () async {
    when(
      userSPMock.getPhone(),
    ).thenAnswer((_) async => "test get phone");

    UserRepository userRepository = UserRepositoryImpl(
      restClient: restUserMock,
      tokenSP: tokenSPMock,
      userSP: userSPMock,
    );

    final responseTest = await userRepository.getPhoneRegistredInSP();
    expect("test get phone", responseTest);
  });

  test('when save phone', () async {
    when(
      userSPMock.savePhone(any),
    ).thenAnswer((_) async => {});

    UserRepository userRepository = UserRepositoryImpl(
      restClient: restUserMock,
      tokenSP: tokenSPMock,
      userSP: userSPMock,
    );

    try {
      await userRepository.savePhoneInSp("");
      expect(true, true);
    } on Exception catch (_) {
      expect(false, true);
    }
  });
}
