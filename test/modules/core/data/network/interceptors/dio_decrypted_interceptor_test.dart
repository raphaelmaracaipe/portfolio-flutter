// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/device_repository.dart';
import 'package:portfolio_flutter/modules/core/data/key_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/interceptors/dio_decrypted_interceptor.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/security/keys.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';
import 'package:portfolio_flutter/modules/core/utils/strings.dart';
import 'package:portfolio_flutter/modules/core/utils/strings_impl.dart';

import 'dio_decrypted_interceptor_test.mocks.dart';

class EncryptionDecryptAESMock extends Mock implements EncryptionDecryptAES {}

class KeysMock extends Mock implements Keys {}

class KeyRepositoryMock extends Mock implements KeyRepository {}

class DeviceRepositoryMock extends Mock implements DeviceRepository {}

class BytesMock extends Mock implements Bytes {}

class TokenSPMock extends Mock implements TokenSP {}

class ResponseInterceptorHandlerMock extends Mock
    implements ResponseInterceptorHandler {}

@GenerateMocks([
  ResponseInterceptorHandlerMock,
  EncryptionDecryptAESMock,
  KeysMock,
  KeyRepositoryMock,
  DeviceRepositoryMock,
  BytesMock,
  TokenSPMock,
])
void main() {
  late DioDecryptedInterceptor interceptor;
  late MockResponseInterceptorHandlerMock responseInterceptorHandlerMock;
  late MockBytesMock bytesMock;
  late MockEncryptionDecryptAESMock encryptionDecryptAESMock;
  late MockKeysMock keysMock;
  late MockKeyRepositoryMock keyRepositoryMock;
  late MockDeviceRepositoryMock deviceRepositoryMock;
  late MockTokenSPMock tokenSPMock;
  final Strings strings = StringsImpl();

  setUp(() {
    responseInterceptorHandlerMock = MockResponseInterceptorHandlerMock();
    encryptionDecryptAESMock = MockEncryptionDecryptAESMock();
    keysMock = MockKeysMock();
    keyRepositoryMock = MockKeyRepositoryMock();
    deviceRepositoryMock = MockDeviceRepositoryMock();
    tokenSPMock = MockTokenSPMock();
    bytesMock = MockBytesMock();

    interceptor = DioDecryptedInterceptor(
      encryptionDecryptAES: encryptionDecryptAESMock,
      keys: keysMock,
      keyRepository: keyRepositoryMock,
      deviceRepository: deviceRepositoryMock,
      bytes: bytesMock,
      tokenSP: tokenSPMock,
    );
  });

  test(
    'when response but not exist key saved request the interceptor get request and take care.',
    () async {
      final Map<String, dynamic> mapResponse = {'data': 'test response'};
      final String jsonMap = jsonEncode(mapResponse);

      when(encryptionDecryptAESMock.decryptData(
        encrypted: anyNamed('encrypted'),
        key: anyNamed('key'),
        iv: anyNamed('iv'),
      )).thenAnswer((_) async => jsonMap);

      when(bytesMock.convertBytesToString(any)).thenAnswer(
        (_) => strings.generateRandomString(20),
      );

      when(
        keyRepositoryMock.getSeed(),
      ).thenAnswer((_) async => "");

      when(
        keyRepositoryMock.getKey(),
      ).thenAnswer((_) async => "");

      final response = Response(
        requestOptions: RequestOptions(data: mapResponse),
        data: mapResponse,
      );

      await interceptor.onResponse(response, responseInterceptorHandlerMock);
      verify(responseInterceptorHandlerMock.next(response));
    },
  );

  test(
    'when response but not exist seed saved request the interceptor get request and take care.',
    () async {
      final Map<String, dynamic> mapResponse = {'data': 'test response'};
      final String jsonMap = jsonEncode(mapResponse);

      when(encryptionDecryptAESMock.decryptData(
        encrypted: anyNamed('encrypted'),
        key: anyNamed('key'),
        iv: anyNamed('iv'),
      )).thenAnswer((_) async => jsonMap);

      when(bytesMock.convertBytesToString(any)).thenAnswer(
        (_) => strings.generateRandomString(20),
      );

      when(
        keyRepositoryMock.getSeed(),
      ).thenAnswer((_) async => "");

      when(
        keyRepositoryMock.getKey(),
      ).thenAnswer((_) async => strings.generateRandomString(10));

      final response = Response(
        requestOptions: RequestOptions(data: mapResponse),
        data: mapResponse,
      );

      await interceptor.onResponse(response, responseInterceptorHandlerMock);
      verify(responseInterceptorHandlerMock.next(response));
    },
  );

  test(
    'when response request the interceptor get request and take care.',
    () async {
      final Map<String, dynamic> mapResponse = {'data': 'test response'};
      final String jsonMap = jsonEncode(mapResponse);

      when(encryptionDecryptAESMock.decryptData(
        encrypted: anyNamed('encrypted'),
        key: anyNamed('key'),
        iv: anyNamed('iv'),
      )).thenAnswer((_) async => jsonMap);

      when(
        keyRepositoryMock.getSeed(),
      ).thenAnswer((_) async => strings.generateRandomString(10));

      when(
        keyRepositoryMock.getKey(),
      ).thenAnswer((_) async => strings.generateRandomString(10));

      final response = Response(
        requestOptions: RequestOptions(data: mapResponse),
        data: mapResponse,
      );

      await interceptor.onResponse(response, responseInterceptorHandlerMock);
      verify(responseInterceptorHandlerMock.next(response));
    },
  );
}
