import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/config/app_key.dart';
import 'package:portfolio_flutter/modules/core/data/device_repository.dart';
import 'package:portfolio_flutter/modules/core/data/key_repository.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/security/keys.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';

class DioDecryptedInterceptor extends Interceptor {
  final EncryptionDecryptAES encryptionDecryptAES;
  final Keys keys;
  final KeyRepository keyRepository;
  final DeviceRepository deviceRepository;
  final Bytes bytes;
  final TokenSP tokenSP;
  final logger = Logger();

  DioDecryptedInterceptor({
    required this.encryptionDecryptAES,
    required this.keys,
    required this.keyRepository,
    required this.deviceRepository,
    required this.bytes,
    required this.tokenSP,
  });

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    await _executePartOfStringToMap(response);
    return handler.next(response);
  }

  Future<void> _executePartOfStringToMap(Response<dynamic> response) async {
    if (response.data.toString().contains("data")) {
      String? dataDecrypted = await _decryptedBody(response);
      if (dataDecrypted.isNotEmpty) {
        response.data = jsonDecode(dataDecrypted);
      }
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

  Future<String> _getKey() async {
    final String keySaved = await keyRepository.getKey();
    return keySaved.isNotEmpty
        ? keySaved
        : bytes.convertBytesToString(AppKey.keyDefault);
  }

  Future<String> _getSeed() async {
    final String seedSaved = await keyRepository.getSeed();
    return seedSaved.isNotEmpty
        ? seedSaved
        : bytes.convertBytesToString(AppKey.seedDefault);
  }
}
