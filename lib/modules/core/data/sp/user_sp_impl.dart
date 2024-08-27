import 'package:portfolio_flutter/config/app_key.dart';
import 'package:portfolio_flutter/modules/core/data/sp/user_sp.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSPImpl extends UserSP {
  final Future<SharedPreferences> sharedPreferences;
  final EncryptionDecryptAES encryptionDecryptAES;
  final Bytes bytes;
  final String _keyOfSharedPhone = 'USER_PHONE';

  UserSPImpl({
    required this.sharedPreferences,
    required this.encryptionDecryptAES,
    required this.bytes,
  });

  @override
  Future<void> savePhone(String phone) async {
    final phoneEncrypted = await encryptionDecryptAES.encryptData(
      text: phone,
      key: bytes.convertBytesToString(AppKey.keyDefault),
      iv: bytes.convertBytesToString(AppKey.seedDefault),
    );

    await (await sharedPreferences).setString(
      _keyOfSharedPhone,
      phoneEncrypted,
    );
  }

  @override
  Future<String> getPhone() async {
    final phoneEncrypted = (await sharedPreferences).getString(
          _keyOfSharedPhone,
        ) ??
        "";

    return await encryptionDecryptAES.decryptData(
      encrypted: phoneEncrypted,
      key: bytes.convertBytesToString(AppKey.keyDefault),
      iv: bytes.convertBytesToString(AppKey.seedDefault),
    );
  }
}
