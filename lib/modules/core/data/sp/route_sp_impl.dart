import 'package:portfolio_flutter/config/app_key.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'route_sp.dart';

class RouteSPImpl extends RouteSP {
  final Future<SharedPreferences> sharedPreferences;
  final EncryptionDecryptAES encryptionDecryptAES;
  final Bytes bytes;
  final String _typeScreenKey = 'TYPESCREEN_KEY1';

  RouteSPImpl({
    required this.bytes,
    required this.sharedPreferences,
    required this.encryptionDecryptAES,
  });

  @override
  Future<void> save(String route) async {
    dynamic routeEncrypted = await encryptionDecryptAES.encryptData(
      text: route,
      key: bytes.convertBytesToString(AppKey.keyDefault),
      iv: bytes.convertBytesToString(AppKey.seedDefault),
    );

    await (await sharedPreferences).setString(_typeScreenKey, routeEncrypted);
  }

  @override
  Future<String> get() async {
    final String routeEncrypted =
        (await sharedPreferences).getString(_typeScreenKey) ?? "";

    if (routeEncrypted.isNotEmpty) {
      return await encryptionDecryptAES.decryptData(
        encrypted: routeEncrypted,
        key: bytes.convertBytesToString(AppKey.keyDefault),
        iv: bytes.convertBytesToString(AppKey.seedDefault),
      );
    }

    return routeEncrypted;
  }

  @override
  Future<void> clean() async {
    final SharedPreferences sp = await sharedPreferences;
    sp.remove(_typeScreenKey);
  }
}
