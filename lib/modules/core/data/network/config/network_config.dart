import 'dart:io';

import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/network/interceptors/dio_encrypted_interceptor.dart';
import 'package:portfolio_flutter/modules/core/data/sp/device_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/security/keys.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';

class NetworkConfig {
  static Dio config({
    required EncryptionDecryptAES encryptionDecryptAES,
    required Keys keys,
    required KeySP keySP,
    required DeviceSP deviceSP,
    required Bytes bytes,
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
        keySP: keySP,
        deviceSP: deviceSP,
        bytes: bytes,
      ),
    );

    return dio;
  }
}
