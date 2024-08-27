import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/sp/user_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/user_sp_impl.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_sp_test.mocks.dart';

class EncryptionDecryptAESMock extends Mock implements EncryptionDecryptAES {}

class SharedPreferenceMock extends Mock implements SharedPreferences {}

@GenerateMocks([EncryptionDecryptAESMock, SharedPreferenceMock])
void main() {
  late MockEncryptionDecryptAESMock encryptionDecryptAESMock;
  late MockSharedPreferenceMock sharedPreferenceMock;
  late UserSP userSP;

  setUp(() {
    encryptionDecryptAESMock = MockEncryptionDecryptAESMock();
    sharedPreferenceMock = MockSharedPreferenceMock();

    userSP = UserSPImpl(
      sharedPreferences: Future.value(sharedPreferenceMock),
      encryptionDecryptAES: encryptionDecryptAESMock,
      bytes: BytesImpl(),
    );
  });

  test('when get phone saved', () async {
    const textOfTest = "text of id";
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

    final returnOfSP = await userSP.getPhone();
    expect(textOfTest, returnOfSP);
  });

  test('when get save phone', () async {
    const textOfTest = "text of id";
    when(
      encryptionDecryptAESMock.encryptData(
        text: anyNamed("text"),
        key: anyNamed("key"),
        iv: anyNamed("iv"),
      ),
    ).thenAnswer((_) async => textOfTest);
    when(
      sharedPreferenceMock.setString(any, any),
    ).thenAnswer((_) async => false);

    try {
      await userSP.savePhone("");
      expect(true, true);
    } on Exception catch (_) {
      expect(true, false);
    }
  });
}
