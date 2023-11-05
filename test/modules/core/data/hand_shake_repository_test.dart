import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/hand_shake_repository.dart';
import 'package:portfolio_flutter/modules/core/data/hand_shake_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_hand_shake.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';
import 'package:portfolio_flutter/modules/core/regex/regex.dart';

import 'hand_shake_repository_test.mocks.dart';

class RestHandShakeMock extends Mock implements RestHandShake {}

class KeySpMock extends Mock implements KeySP {}

class RegexMock extends Mock implements Regex {}

@GenerateMocks([
  RestHandShakeMock,
  KeySpMock,
  RegexMock,
])
void main() {
  late MockRestHandShakeMock restHandShakeMock;
  late MockKeySpMock keySpMock;
  late MockRegexMock regexMock;

  setUp(() {
    restHandShakeMock = MockRestHandShakeMock();
    keySpMock = MockKeySpMock();
    regexMock = MockRegexMock();

    when(regexMock.generateString(
      regexPattern: anyNamed('regexPattern'),
    )).thenAnswer((_) async => "AAA");
  });

  test('when exist key saved in sp', () async {
    when(keySpMock.isExistKeyAndIVSaved()).thenAnswer((_) async => true);
    HandShakeRepository handShakeRepository = HandShakeRepositoryImpl(
      keySP: keySpMock,
      restHandShake: restHandShakeMock,
      regex: regexMock,
    );

    try {
      await handShakeRepository.send();
      expect(true, true);
    } on Exception {
      expect(false, true);
    }
  });

  test('when send request to server but return error', () async {
    when(keySpMock.isExistKeyAndIVSaved()).thenAnswer((_) async => false);
    when(
      restHandShakeMock.requestHandShake(any),
    ).thenThrow(DioException(requestOptions: RequestOptions()));

    HandShakeRepository handShakeRepository = HandShakeRepositoryImpl(
      keySP: keySpMock,
      restHandShake: restHandShakeMock,
      regex: regexMock,
    );

    try {
      await handShakeRepository.send();
      expect(true, false);
    } on HttpException catch (e) {
      expect(HttpErrorEnum.UNKNOWN, e.enumError);
    }
  });

  test('when send request to server but return error generic', () async {
    when(keySpMock.isExistKeyAndIVSaved()).thenAnswer((_) async => false);
    when(
      restHandShakeMock.requestHandShake(any),
    ).thenThrow(Exception("error"));

    HandShakeRepository handShakeRepository = HandShakeRepositoryImpl(
      keySP: keySpMock,
      restHandShake: restHandShakeMock,
      regex: regexMock,
    );

    try {
      await handShakeRepository.send();
      expect(true, false);
    } on HttpException catch (e) {
      expect(HttpErrorEnum.ERROR_GENERAL, e.enumError);
    }
  });

  test('when send request to server return success', () async {
    when(keySpMock.isExistKeyAndIVSaved()).thenAnswer((_) async => false);
    when(keySpMock.saveSeed(any)).thenAnswer((_) async {});
    when(keySpMock.saveKey(any)).thenAnswer((_) async {});
    when(
      restHandShakeMock.requestHandShake(any),
    ).thenAnswer((_) async {});

    HandShakeRepository handShakeRepository = HandShakeRepositoryImpl(
      keySP: keySpMock,
      restHandShake: restHandShakeMock,
      regex: regexMock,
    );

    try {
      await handShakeRepository.send();
      expect(true, true);
    } on HttpException {
      expect(true, false);
    }
  });
}
