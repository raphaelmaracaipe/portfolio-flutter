import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:portfolio_flutter/config/app_key.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenSPImpl extends TokenSP {
  final Future<SharedPreferences> sharedPreferences;
  final EncryptionDecryptAES encryptionDecryptAES;
  final Bytes bytes;
  final String _keyShared = 'TOKENS';

  TokenSPImpl({
    required this.sharedPreferences,
    required this.encryptionDecryptAES,
    required this.bytes,
  });

  @override
  Future<void> save(ResponseValidCode responseValidCode) async {
    final responValidCodeJsonToString = jsonEncode(responseValidCode.toJson());
    dynamic responseValidCodeEncrypted = await encryptionDecryptAES.encryptData(
      text: responValidCodeJsonToString,
      key: bytes.convertBytesToString(AppKey.keyDefault),
      iv: bytes.convertBytesToString(AppKey.seedDefault),
    );

    await (await sharedPreferences).setString(
      _keyShared,
      responseValidCodeEncrypted,
    );
  }

  @override
  Future<ResponseValidCode> get() async {
    final dataSaved = (await sharedPreferences).getString(
          _keyShared,
        ) ??
        "";

    if (dataSaved.isEmpty) {
      return ResponseValidCode();
    }

    final dataDecrypted = await encryptionDecryptAES.decryptData(
      encrypted: dataSaved,
      key: bytes.convertBytesToString(AppKey.keyDefault),
      iv: bytes.convertBytesToString(AppKey.seedDefault),
    );

    final dataJsonDecoded = jsonDecode(dataDecrypted);
    return ResponseValidCode.fromJson(dataJsonDecoded);
  }
}
