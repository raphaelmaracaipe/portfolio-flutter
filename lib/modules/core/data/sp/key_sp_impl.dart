import 'package:portfolio_flutter/config/app_key.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'key_sp.dart';

class KeySPImpl extends KeySP {
  final Future<SharedPreferences> sharedPreference;
  final EncryptionDecryptAES encryptionDecryptAES;
  final Bytes bytes;
  final String _keyShared = 'KEY';
  final String _ivShared = 'IV';

  KeySPImpl({
    required this.sharedPreference,
    required this.encryptionDecryptAES,
    required this.bytes,
  });

  @override
  Future<void> saveKey(String key) async {
    dynamic routeEncrypted = await encryptionDecryptAES.encryptData(
      text: key,
      key: bytes.convertBytesToString(AppKey.keyDefault),
      iv: bytes.convertBytesToString(AppKey.seedDefault),
    );

    await (await sharedPreference).setString(_keyShared, routeEncrypted);
  }

  @override
  Future<String> getKey() async {
    String keySavedInSP = (await sharedPreference).getString(_keyShared) ?? "";
    if (keySavedInSP.isEmpty) {
      return keySavedInSP;
    }

    return await encryptionDecryptAES.decryptData(
      encrypted: keySavedInSP,
      key: bytes.convertBytesToString(AppKey.keyDefault),
      iv: bytes.convertBytesToString(AppKey.seedDefault),
    );
  }

  @override
  Future<String> getSeed() async {
    String ivSavedInSP = (await sharedPreference).getString(_ivShared) ?? "";
    if (ivSavedInSP.isEmpty) {
      return ivSavedInSP;
    }

    return await encryptionDecryptAES.decryptData(
      encrypted: ivSavedInSP,
      key: bytes.convertBytesToString(AppKey.keyDefault),
      iv: bytes.convertBytesToString(AppKey.seedDefault),
    );
  }

  @override
  Future<void> saveSeed(String seed) async {
    dynamic ivEncrypted = await encryptionDecryptAES.encryptData(
      text: seed,
      key: bytes.convertBytesToString(AppKey.keyDefault),
      iv: bytes.convertBytesToString(AppKey.seedDefault),
    );

    await (await sharedPreference).setString(_ivShared, ivEncrypted);
  }

  @override
  Future<bool> isExistKeyAndIVSaved() async {
    final sp = await sharedPreference;
    final ivIsSaved = sp.getString(_ivShared)?.isNotEmpty ?? false;
    final keyIsSaved = sp.getString(_keyShared)?.isNotEmpty ?? false;

    return ivIsSaved && keyIsSaved;
  }
}
