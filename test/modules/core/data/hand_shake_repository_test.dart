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
import 'package:portfolio_flutter/modules/core/security/keys_impl.dart';

import 'hand_shake_repository_test.mocks.dart';

class RestHandShakeMock extends Mock implements RestHandShake {}

class KeySpMock extends Mock implements KeySP {}

@GenerateMocks([RestHandShakeMock, KeySpMock])
void main() {
  late MockRestHandShakeMock restHandShakeMock;
  late MockKeySpMock keySpMock;

  setUp(() {
    restHandShakeMock = MockRestHandShakeMock();
    keySpMock = MockKeySpMock();
  });

  test('when exist key saved in sp', () async {
    when(keySpMock.isExistKeyAndIVSaved()).thenAnswer((_) async => true);
    HandShakeRepository handShakeRepository = HandShakeRepositoryImpl(
      keySP: keySpMock,
      restHandShake: restHandShakeMock,
      key: KeysImpl(),
    );

    try {
      await handShakeRepository.send();
      expect(true, true);
    } catch (e) {
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
      key: KeysImpl(),
    );

    try {
      await handShakeRepository.send();
      expect(true, false);
    } on HttpException catch (e) {
      expect(HttpErrorEnum.UNKNOWN, e.enumError);
    }
  });

  test('when send request to server return success', () async {
    when(keySpMock.isExistKeyAndIVSaved()).thenAnswer((_) async => false);
    when(keySpMock.saveIV(any)).thenAnswer((_) async {});
    when(keySpMock.saveKey(any)).thenAnswer((_) async {});
    when(
      restHandShakeMock.requestHandShake(any),
    ).thenAnswer((_) async {});

    HandShakeRepository handShakeRepository = HandShakeRepositoryImpl(
      keySP: keySpMock,
      restHandShake: restHandShakeMock,
      key: KeysImpl(),
    );

    try {
      await handShakeRepository.send();
      expect(true, true);
    } on HttpException catch (e) {
      expect(true, false);
    }
  });
}
