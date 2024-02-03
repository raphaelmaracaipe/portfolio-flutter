import 'dart:io';

import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/device_repository.dart';
import 'package:portfolio_flutter/modules/core/data/key_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/interceptors/dio_encrypted_interceptor.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/security/keys.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';

class NetworkConfig {
  static Dio config({
    required EncryptionDecryptAES encryptionDecryptAES,
    required Keys keys,
    required KeyRepository keyRepository,
    required DeviceRepository deviceRepository,
    required Bytes bytes,
    required TokenSP tokenSP,
  }) {
    final Dio dio = Dio(
      BaseOptions(
        contentType: ContentType.json.toString(),
        connectTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(
      DioEncryptedInterceptor(
        encryptionDecryptAES: encryptionDecryptAES,
        keys: keys,
        keyRepository: keyRepository,
        deviceRepository: deviceRepository,
        bytes: bytes,
        tokenSP: tokenSP,
      ),
    );

    return dio;
  }
}
