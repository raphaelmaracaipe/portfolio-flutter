import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/network/interceptors/dio_encrypted_interceptor.dart';
import 'package:portfolio_flutter/modules/core/data/sp/device_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/security/keys.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes_impl.dart';

import 'dio_encrypted_interceptor_test.mocks.dart';

class EncryptionDecryptAESMock extends Mock implements EncryptionDecryptAES {}

class KeysMock extends Mock implements Keys {}

class KeySPMock extends Mock implements KeySP {}

class DeviceSPMock extends Mock implements DeviceSP {}

class BytesMock extends Mock implements Bytes {}

class ResponseInterceptorHandlerMock extends Mock
    implements ResponseInterceptorHandler {}

class RequestInterceptorHandlerMock extends Mock
    implements RequestInterceptorHandler {}

@GenerateMocks([
  RequestInterceptorHandlerMock,
  ResponseInterceptorHandlerMock,
  EncryptionDecryptAESMock,
  KeysMock,
  KeySPMock,
  DeviceSPMock,
  BytesMock,
])
void main() {
  late DioEncryptedInterceptor interceptor;
  late MockRequestInterceptorHandlerMock requestInterceptorHandlerMock;
  late MockResponseInterceptorHandlerMock responseInterceptorHandlerMock;
  late MockEncryptionDecryptAESMock encryptionDecryptAESMock;
  late MockKeysMock keysMock;
  late MockKeySPMock keySPMock;
  late MockDeviceSPMock deviceSPMock;

  setUp(() {
    encryptionDecryptAESMock = MockEncryptionDecryptAESMock();
    requestInterceptorHandlerMock = MockRequestInterceptorHandlerMock();
    responseInterceptorHandlerMock = MockResponseInterceptorHandlerMock();
    keysMock = MockKeysMock();
    keySPMock = MockKeySPMock();
    deviceSPMock = MockDeviceSPMock();

    interceptor = DioEncryptedInterceptor(
      encryptionDecryptAES: encryptionDecryptAESMock,
      keys: keysMock,
      keySP: keySPMock,
      deviceSP: deviceSPMock,
      bytes: BytesImpl(),
    );
  });

  test('when interceptor response when decrypted is empty', () async {
    when(keySPMock.getKey()).thenAnswer((_) async => "");
    when(keySPMock.getSeed()).thenAnswer((_) async => "");

    when(encryptionDecryptAESMock.decryptData(
      encrypted: anyNamed('encrypted'),
      key: anyNamed('key'),
      iv: anyNamed('iv'),
    )).thenAnswer((_) async => '');

    Response response = Response(
      data: {
        'data': '',
      },
      requestOptions: RequestOptions(),
    );

    await interceptor.onResponse(response, responseInterceptorHandlerMock);
    verify(responseInterceptorHandlerMock.next(response));
  });

  test('when interceptor response when decrypted is not empty', () async {
    when(keySPMock.getKey()).thenAnswer((_) async => "");
    when(keySPMock.getSeed()).thenAnswer((_) async => "");

    final Map<String, dynamic> mapResponse = {'data': 'test response'};
    final String jsonMap = jsonEncode(mapResponse);

    when(encryptionDecryptAESMock.decryptData(
      encrypted: anyNamed('encrypted'),
      key: anyNamed('key'),
      iv: anyNamed('iv'),
    )).thenAnswer((_) async => jsonMap);

    Response response = Response(
      data: mapResponse,
      requestOptions: RequestOptions(),
    );

    await interceptor.onResponse(response, responseInterceptorHandlerMock);
    verify(responseInterceptorHandlerMock.next(response));
  });

  test('when interceptor request when decrypted', () async {
    when(keySPMock.getKey()).thenAnswer((_) async => "AAA");
    when(keySPMock.getSeed()).thenAnswer((_) async => "BBB");
    when(deviceSPMock.getDeviceID()).thenAnswer((_) async => "BBB");

    when(encryptionDecryptAESMock.encryptData(
      text: anyNamed('text'),
      key: anyNamed('key'),
      iv: anyNamed('iv'),
    )).thenAnswer((_) async => "body encrypted");

    final jsonString = jsonEncode({'data': 'test'});
    final mockOptions = RequestOptions(data: jsonString);
    await interceptor.onRequest(mockOptions, requestInterceptorHandlerMock);

    expect(mockOptions.headers, containsPair('device_id', 'BBB'));
  });
}
