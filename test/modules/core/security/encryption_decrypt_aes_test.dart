import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes_impl.dart';

import 'encryption_decrypt_aes_test.mocks.dart';

class MethodChannelMock extends Mock implements MethodChannel {}

@GenerateMocks([MethodChannelMock])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const String key = 'ABCDEFGYUITRG65@';
  const String iv = 'a';
  final MockMethodChannelMock methodChannelMock = MockMethodChannelMock();

  test('when send data to decrypted and return data with success', () async {
    String textReturned = "test";
    when(
      methodChannelMock.invokeMethod(any, any),
    ).thenAnswer((_) async => textReturned);

    EncryptionDecryptAES encryption = EncryptionDecryptAESImpl(
      encryptionChannel: methodChannelMock,
    );

    dynamic test = await encryption.decryptData(
      encrypted: 'test',
      key: key,
      iv: iv,
    );
    expect(textReturned, test);
  });

  test('when send data to decrypt but ocorrend error', () async {
    String textTest = 'test fail';
    when(
      methodChannelMock.invokeMethod(any, any),
    ).thenThrow(PlatformException(message: textTest, code: "500"));

    EncryptionDecryptAES encryption = EncryptionDecryptAESImpl(
      encryptionChannel: methodChannelMock,
    );

    try {
      await encryption.decryptData(encrypted: 'encrypted', key: key, iv: iv);
      expect(false, true);
    } on Exception catch (e) {
      expect(e.toString().contains(textTest), true);
    }
  });

  test('when send data to encrypt and return data with success', () async {
    String textReturned = "test";
    when(
      methodChannelMock.invokeMethod(any, any),
    ).thenAnswer((_) async => textReturned);

    EncryptionDecryptAES encryption = EncryptionDecryptAESImpl(
      encryptionChannel: methodChannelMock,
    );

    dynamic test = await encryption.encryptData(text: 'test', key: key, iv: iv);
    expect(textReturned, test);
  });

  test('when send data to encrypt but ocorrend error', () async {
    String textTest = 'test fail';
    when(
      methodChannelMock.invokeMethod(any, any),
    ).thenThrow(PlatformException(message: textTest, code: "500"));

    EncryptionDecryptAES encryption = EncryptionDecryptAESImpl(
      encryptionChannel: methodChannelMock,
    );

    try {
      await encryption.encryptData(text: 'encrypted', key: key, iv: iv);
      expect(false, true);
    } on Exception catch (e) {
      expect(e.toString().contains(textTest), true);
    }
  });
}
