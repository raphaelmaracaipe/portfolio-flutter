import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/device_repository.dart';
import 'package:portfolio_flutter/modules/core/data/key_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/interceptors/dio_encrypted_interceptor.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_token.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/security/keys.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes_impl.dart';
import 'package:portfolio_flutter/modules/core/utils/strings.dart';
import 'package:portfolio_flutter/modules/core/utils/strings_impl.dart';

import 'dio_encrypted_interceptor_test.mocks.dart';

class EncryptionDecryptAESMock extends Mock implements EncryptionDecryptAES {}

class KeysMock extends Mock implements Keys {}

class KeyRepositoryMock extends Mock implements KeyRepository {}

class DeviceRepositoryMock extends Mock implements DeviceRepository {}

class BytesMock extends Mock implements Bytes {}

class TokenSPMock extends Mock implements TokenSP {}

class ResponseInterceptorHandlerMock extends Mock
    implements ResponseInterceptorHandler {}

class RequestInterceptorHandlerMock extends Mock
    implements RequestInterceptorHandler {}

@GenerateMocks([
  ResponseInterceptorHandlerMock,
  RequestInterceptorHandlerMock,
  EncryptionDecryptAESMock,
  KeysMock,
  KeyRepositoryMock,
  DeviceRepositoryMock,
  BytesMock,
  TokenSPMock,
])
void main() {
  late DioEncryptedInterceptor interceptor;
  late MockResponseInterceptorHandlerMock responseInterceptorHandlerMock;
  late MockRequestInterceptorHandlerMock requestInterceptorHandlerMock;
  late MockEncryptionDecryptAESMock encryptionDecryptAESMock;
  late MockKeysMock keysMock;
  late MockKeyRepositoryMock keyRepositoryMock;
  late MockDeviceRepositoryMock deviceRepositoryMock;
  late MockTokenSPMock tokenSPMock;
  final Strings strings = StringsImpl();

  setUp(() {
    encryptionDecryptAESMock = MockEncryptionDecryptAESMock();
    responseInterceptorHandlerMock = MockResponseInterceptorHandlerMock();
    requestInterceptorHandlerMock = MockRequestInterceptorHandlerMock();
    keysMock = MockKeysMock();
    keyRepositoryMock = MockKeyRepositoryMock();
    deviceRepositoryMock = MockDeviceRepositoryMock();
    tokenSPMock = MockTokenSPMock();

    interceptor = DioEncryptedInterceptor(
      encryptionDecryptAES: encryptionDecryptAESMock,
      keys: keysMock,
      keyRepository: keyRepositoryMock,
      deviceRepository: deviceRepositoryMock,
      bytes: BytesImpl(),
      tokenSP: tokenSPMock,
    );
  });

  test('when interceptor request when decrypted', () async {
    when(keyRepositoryMock.getKey()).thenAnswer(
      (_) async => strings.generateRandomString(10),
    );
    when(keyRepositoryMock.getSeed()).thenAnswer(
      (_) async => strings.generateRandomString(10),
    );
    when(deviceRepositoryMock.getID()).thenAnswer(
      (_) async => strings.generateRandomString(10),
    );
    when(tokenSPMock.get()).thenAnswer(
      (_) async => ResponseToken(
        refreshToken: strings.generateRandomString(5),
        accessToken: strings.generateRandomString(5),
      ),
    );

    when(encryptionDecryptAESMock.encryptData(
      text: anyNamed('text'),
      key: anyNamed('key'),
      iv: anyNamed('iv'),
    )).thenAnswer((_) async => "body encrypted");

    final jsonString = jsonEncode({'data': 'test'});
    final mockOptions = RequestOptions(data: jsonString);

    await interceptor.onRequest(mockOptions, requestInterceptorHandlerMock);
    expect(true, mockOptions.headers.containsKey('device_id'));
  });
}
