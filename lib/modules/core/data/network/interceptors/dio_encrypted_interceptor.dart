import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/config/app_key.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_encrypted.dart';
import 'package:portfolio_flutter/modules/core/data/sp/device_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/security/keys.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';

class DioEncryptedInterceptor extends Interceptor {
  final EncryptionDecryptAES encryptionDecryptAES;
  final Keys keys;
  final KeySP keySP;
  final DeviceSP deviceSP;
  final Bytes bytes;

  DioEncryptedInterceptor({
    required this.encryptionDecryptAES,
    required this.keys,
    required this.keySP,
    required this.deviceSP,
    required this.bytes,
  });

  Logger logger = Logger();

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    await _executePartOfStringToMap(response);
    return handler.next(response);
  }

  Future<void> _executePartOfStringToMap(Response<dynamic> response) async {
    String dataDecrypted = await _decryptedBody(response);
    if (dataDecrypted.isNotEmpty) {
      response.data = jsonDecode(dataDecrypted);
    }
  }

  Future<String> _decryptedBody(Response<dynamic> response) async {
    Map<String, dynamic> data = response.data;
    final String dataEncrypted = data["data"];
    final String dataDecrypted = await encryptionDecryptAES.decryptData(
      encrypted: dataEncrypted,
      key: await _getKey(),
      iv: await _getSeed(),
    );
    return dataDecrypted;
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final iv = await _getSeed();
    await _encryptDataToSendInBody(options, iv);

    options.headers = {
      "x-api-key": _randomApiKey(),
      "device_id": await deviceSP.getDeviceID(),
      "seed": await _encryptIV(iv),
    };

    return handler.next(options);
  }

  Future<void> _encryptDataToSendInBody(
    RequestOptions options,
    String iv,
  ) async {
    final String bodyEncrypted = await encryptionDecryptAES.encryptData(
      text: json.encode(options.data),
      key: await _getKey(),
      iv: iv,
    );

    options.data = RequestEncrypted(data: bodyEncrypted).toJson();
  }

  Future<String> _getKey() async {
    final String keySaved = await keySP.getKey();
    return keySaved.isNotEmpty
        ? keySaved
        : bytes.convertBytesToString(AppKey.keyDefault);
  }

  static String _randomApiKey() {
    final List<String> keys = [
      'd2e621a6646a4211768cd68e26f21228a81',
      'ca03na188ame03u1d78620de67282882a84'
    ];

    final Random random = Random();
    return keys[random.nextInt(keys.length)];
  }

  Future<String> _getSeed() async {
    final String seedSaved = await keySP.getSeed();
    return seedSaved.isNotEmpty
        ? seedSaved
        : bytes.convertBytesToString(AppKey.seedDefault);
  }

  FutureOr<String> _encryptIV(String iv) async {
    try {
      final String ivEncrypted = await encryptionDecryptAES.encryptData(
        text: iv,
        key: bytes.convertBytesToString(AppKey.keyDefault),
        iv: bytes.convertBytesToString(AppKey.seedDefault),
      );
      return ivEncrypted.replaceAll("\n", "");
    } catch (e) {
      return iv;
    }
  }
}
