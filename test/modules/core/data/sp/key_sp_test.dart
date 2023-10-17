import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp_impl.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'key_sp_test.mocks.dart';

class EncryptionDecryptAESMock extends Mock implements EncryptionDecryptAES {}

class SharedPreferencesMock extends Mock implements SharedPreferences {}

@GenerateMocks([
  EncryptionDecryptAESMock,
  SharedPreferencesMock,
])
void main() {
  late MockEncryptionDecryptAESMock encryptionDecryptAESMock;
  late MockSharedPreferencesMock sharedPreferencesMock;
  late KeySP keySP;

  setUp(() {
    encryptionDecryptAESMock = MockEncryptionDecryptAESMock();
    sharedPreferencesMock = MockSharedPreferencesMock();

    keySP = KeySPImpl(
      sharedPreference: Future.value(sharedPreferencesMock),
      encryptionDecryptAES: encryptionDecryptAESMock,
      bytes: BytesImpl(),
    );
  });

  test('when want save your key', () async {
    when(
      encryptionDecryptAESMock.encryptData(
        text: anyNamed("text"),
        key: anyNamed("key"),
        iv: anyNamed("iv"),
      ),
    ).thenAnswer((_) async => "test encryption");
    when(
      sharedPreferencesMock.setString(any, any),
    ).thenAnswer((_) async => true);

    try {
      await keySP.saveKey("test");
      expect(true, true);
    } on Exception {
      expect(false, true);
    }
  });

  test('when get key saved but not exist key saved', () async {
    const String toText = "";
    when(
      sharedPreferencesMock.getString(any),
    ).thenReturn(toText);

    try {
      final keySaved = await keySP.getKey();
      expect(keySaved, toText);
    } on Exception {
      expect(true, false);
    }
  });

  test('when get key saved', () async {
    const String toText = "test";
    when(
      sharedPreferencesMock.getString(any),
    ).thenReturn(toText);
    when(encryptionDecryptAESMock.decryptData(
      encrypted: anyNamed("encrypted"),
      key: anyNamed("key"),
      iv: anyNamed("iv"),
    )).thenAnswer((_) async => toText);

    try {
      final keySaved = await keySP.getKey();
      expect(keySaved, toText);
    } on Exception {
      expect(true, false);
    }
  });

  test('when want save your seed', () async {
    when(
      encryptionDecryptAESMock.encryptData(
        text: anyNamed("text"),
        key: anyNamed("key"),
        iv: anyNamed("iv"),
      ),
    ).thenAnswer((_) async => "test encryption");
    when(
      sharedPreferencesMock.setString(any, any),
    ).thenAnswer((_) async => true);

    try {
      await keySP.saveSeed("test");
      expect(true, true);
    } on Exception {
      expect(false, true);
    }
  });

  test('when get key saved but not exist seed saved', () async {
    const String toText = "";
    when(
      sharedPreferencesMock.getString(any),
    ).thenReturn(toText);

    try {
      final seedSaved = await keySP.getSeed();
      expect(seedSaved, toText);
    } on Exception {
      expect(true, false);
    }
  });

  test('when get seed saved', () async {
    const String toText = "test";
    when(
      sharedPreferencesMock.getString(any),
    ).thenReturn(toText);
    when(encryptionDecryptAESMock.decryptData(
      encrypted: anyNamed("encrypted"),
      key: anyNamed("key"),
      iv: anyNamed("iv"),
    )).thenAnswer((_) async => toText);

    try {
      final seedSaved = await keySP.getSeed();
      expect(seedSaved, toText);
    } on Exception {
      expect(true, false);
    }
  });

  test('when check if exist key and seed saved', () async {
    when(
      sharedPreferencesMock.getString(any),
    ).thenReturn("test of save");

    try {
      final isExist = await keySP.isExistKeyAndIVSaved();
      expect(isExist, true);
    } on Exception {
      expect(true, false);
    }
  });

  test('when check if exist key and seed saved but not exist', () async {
    when(
      sharedPreferencesMock.getString(any),
    ).thenReturn("");

    try {
      final isExist = await keySP.isExistKeyAndIVSaved();
      expect(isExist, false);
    } on Exception {
      expect(true, false);
    }
  });

  test('when clean data of seed should call method', () async {
    when(
      sharedPreferencesMock.setString(any, any)
    ).thenAnswer((_) async => true);

    try {
      await keySP.cleanSeed();
      expect(true, true);
    } on Exception {
      expect(false, true);
    }
  });
}
