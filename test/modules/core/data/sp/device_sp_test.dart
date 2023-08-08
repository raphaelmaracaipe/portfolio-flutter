import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/sp/device_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/device_sp_impl.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'device_sp_test.mocks.dart';

class EncryptionDecryptAESMock extends Mock implements EncryptionDecryptAES {}

class SharedPreferenceMock extends Mock implements SharedPreferences {}

@GenerateMocks([
  EncryptionDecryptAESMock,
  SharedPreferenceMock,
])
void main() {
  late MockEncryptionDecryptAESMock encryptionDecryptAESMock;
  late MockSharedPreferenceMock sharedPreferenceMock;
  late DeviceSP deviceSP;

  setUp(() {
    encryptionDecryptAESMock = MockEncryptionDecryptAESMock();
    sharedPreferenceMock = MockSharedPreferenceMock();

    deviceSP = DeviceSPImpl(
      sharedPreference: Future.value(sharedPreferenceMock),
      encryptionDecryptAES: encryptionDecryptAESMock,
      bytes: BytesImpl(),
    );
  });

  test('when get device id but is not exist device saved', () async {
    const String textOfTest = "";
    when(
      encryptionDecryptAESMock.encryptData(
        text: anyNamed("text"),
        key: anyNamed("key"),
        iv: anyNamed("iv"),
      ),
    ).thenAnswer((_) async => textOfTest);
    when(
      sharedPreferenceMock.getString(any),
    ).thenReturn(textOfTest);
    when(
      sharedPreferenceMock.setString(any, any),
    ).thenAnswer((_) async => true);

    final String textSaved = await deviceSP.getDeviceID();
    expect(textSaved.isNotEmpty, true);
  });

  test('when get device id which are saved in sp', () async {
    const String textOfTest = "device id";
    when(
      encryptionDecryptAESMock.decryptData(
        encrypted: anyNamed("encrypted"),
        key: anyNamed("key"),
        iv: anyNamed("iv"),
      ),
    ).thenAnswer((_) async => textOfTest);
    when(
      sharedPreferenceMock.getString(any),
    ).thenReturn(textOfTest);

    final String textSaved = await deviceSP.getDeviceID();
    expect(textOfTest, textSaved);
  });

}
