import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/config/app_api.dart';
import 'package:portfolio_flutter/config/app_key.dart';
import 'package:portfolio_flutter/modules/core/data/device_repository.dart';
import 'package:portfolio_flutter/modules/core/data/key_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_encrypted.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/security/keys.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';

class DioEncryptedInterceptor extends Interceptor {
  final EncryptionDecryptAES encryptionDecryptAES;
  final Keys keys;
  final KeyRepository keyRepository;
  final DeviceRepository deviceRepository;
  final Bytes bytes;
  final TokenSP tokenSP;
  final logger = Logger();

  DioEncryptedInterceptor({
    required this.encryptionDecryptAES,
    required this.keys,
    required this.keyRepository,
    required this.deviceRepository,
    required this.bytes,
    required this.tokenSP,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final iv = await _getSeed();
    await _encryptDataToSendInBody(options, iv);

    options.headers = {
      "x-api-key": _randomApiKey(),
      "device_id": Uri.encodeComponent(await deviceRepository.getID()),
      "seed": await _encryptIV(iv),
    };

    await _checkAndAddAuthorization(options);
    return handler.next(options);
  }

  Future<void> _checkAndAddAuthorization(RequestOptions options) async {
    try {
      final tokenResponse = await tokenSP.get();
      if (tokenResponse.accessToken?.isNotEmpty ?? false) {
        options.headers = {
          ...options.headers,
          "authorization": "Bearer ${tokenResponse.accessToken}",
        };
      }
    } on Exception catch (_) {}
  }

  Future<void> _encryptDataToSendInBody(
    RequestOptions options,
    String iv,
  ) async {
    if (!options.data.toString().contains("data: ")) {
      final bodyEncrypted = await encryptionDecryptAES.encryptData(
        text: json.encode(options.data),
        key: await _getKey(),
        iv: iv,
      );

      options.data = RequestEncrypted(
        data: Uri.encodeComponent(bodyEncrypted),
      ).toJson();
    }
  }

  Future<String> _getKey() async {
    final String keySaved = await keyRepository.getKey();
    return keySaved.isNotEmpty
        ? keySaved
        : bytes.convertBytesToString(AppKey.keyDefault);
  }

  static String _randomApiKey() {
    final Random random = Random();
    return AppApi.keys[random.nextInt(AppApi.keys.length)];
  }

  Future<String> _getSeed() async {
    final String seedSaved = await keyRepository.getSeed();
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

      return Uri.encodeComponent(ivEncrypted);
    } on Exception catch (_) {
      return iv;
    }
  }
}
