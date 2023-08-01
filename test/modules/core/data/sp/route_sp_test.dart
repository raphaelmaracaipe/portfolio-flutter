import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/sp/route_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/route_sp_impl.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'route_sp_test.mocks.dart';

class EncryptionDecryptAESMock extends Mock implements EncryptionDecryptAES {}

class SharedPreferenceMock extends Mock implements SharedPreferences {}

@GenerateMocks([
  EncryptionDecryptAESMock,
  SharedPreferenceMock,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockEncryptionDecryptAESMock encryptionDecryptAESMock;
  late MockSharedPreferenceMock sharedPreferenceMock;
  late RouteSP routeSP;

  setUp(() {
    encryptionDecryptAESMock = MockEncryptionDecryptAESMock();
    sharedPreferenceMock = MockSharedPreferenceMock();

    routeSP = RouteSPImpl(
      bytes: BytesImpl(),
      sharedPreferences: Future.value(sharedPreferenceMock),
      encryptionDecryptAES: encryptionDecryptAESMock,
    );
  });

  test('when save route', () async {
    when(
      encryptionDecryptAESMock.encryptData(any, any),
    ).thenAnswer((_) async => 'test');

    when(
      sharedPreferenceMock.setString(any, any),
    ).thenAnswer((_) async => true);

    try {
      await routeSP.save('test');
      expect(true, true);
    } catch (e) {
      expect(true, false);
    }
  });

  test('when get route save', () async {
    String textOfText = 'test';
    when(
      encryptionDecryptAESMock.decryptData(any, any),
    ).thenAnswer((_) async => textOfText);

    when(
      sharedPreferenceMock.getString(any),
    ).thenReturn(textOfText);

    String routeSaved = await routeSP.get();
    expect(routeSaved, textOfText);
  });

  test('when get route save but not exist data saved', () async {
    String textOfText = '';
    when(
      sharedPreferenceMock.getString(any),
    ).thenReturn(textOfText);

    String routeSaved = await routeSP.get();
    expect(routeSaved, textOfText);
  });

  test('when clean data in sp', () async {
    when(
      sharedPreferenceMock.remove(any),
    ).thenAnswer((_) async => true);

    try {
      await routeSP.clean();
      expect(true, true);
    } catch (e) {
      expect(false, true);
    }
  });
}
