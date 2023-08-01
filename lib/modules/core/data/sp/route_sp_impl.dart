import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'route_sp.dart';

class RouteSPImpl extends RouteSP {
  final Future<SharedPreferences> sharedPreferences;
  final EncryptionDecryptAES encryptionDecryptAES;
  final Bytes bytes;
  final String _typeScreenKey = 'TYPESCREEN_KEY';
  final List<int> _key = [
    97,
    115,
    107,
    106,
    100,
    52,
    52,
    51,
    50,
    97,
    106,
    100,
    108,
    64,
    113,
    57
  ];

  RouteSPImpl({
    required this.bytes,
    required this.sharedPreferences,
    required this.encryptionDecryptAES,
  });

  @override
  Future<void> save(String route) async {
    dynamic routeEncrypted = await encryptionDecryptAES.encryptData(
      route,
      bytes.convertBytesToString(_key),
    );

    final SharedPreferences sp = await sharedPreferences;
    await sp.setString(_typeScreenKey, routeEncrypted);
  }

  @override
  Future<String> get() async {
    final SharedPreferences sp = await sharedPreferences;
    final String routeEncrypted = sp.getString(_typeScreenKey) ?? "";

    if (routeEncrypted.isNotEmpty) {
      return await encryptionDecryptAES.decryptData(
        routeEncrypted,
        bytes.convertBytesToString(_key),
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
