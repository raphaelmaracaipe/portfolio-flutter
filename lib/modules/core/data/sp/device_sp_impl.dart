import 'package:portfolio_flutter/config/app_key.dart';
import 'package:portfolio_flutter/modules/core/data/sp/device_sp.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceSPImpl extends DeviceSP {
  final Future<SharedPreferences> sharedPreference;
  final EncryptionDecryptAES encryptionDecryptAES;
  final Bytes bytes;
  final String _keyOfShared = 'DEVICE';

  DeviceSPImpl({
    required this.sharedPreference,
    required this.encryptionDecryptAES,
    required this.bytes,
  });

  @override
  Future<String> getDeviceID() async {
    final SharedPreferences sp = await sharedPreference;
    return sp.getString(_keyOfShared) ?? "";
  }

  @override
  Future<void> save(String id) async {
    final keyEncrypted = await encryptionDecryptAES.encryptData(
      text: id,
      key: bytes.convertBytesToString(AppKey.keyDefault),
      iv: bytes.convertBytesToString(AppKey.seedDefault),
    );

    await (await sharedPreference).setString(_keyOfShared, keyEncrypted);
  }
}
