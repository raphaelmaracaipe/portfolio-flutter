import 'dart:io';

import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/device_repository.dart';
import 'package:portfolio_flutter/modules/core/data/key_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/interceptors/dio_decrypted_interceptor.dart';
import 'package:portfolio_flutter/modules/core/data/network/interceptors/dio_encrypted_interceptor.dart';
import 'package:portfolio_flutter/modules/core/data/network/interceptors/dio_error_interceptor.dart';
import 'package:portfolio_flutter/modules/core/data/sp/device_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/route_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/user_sp.dart';
import 'package:portfolio_flutter/modules/core/data/token_interceptor_repository.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/security/keys.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';

class NetworkConfig {
  static Dio config({
    EncryptionDecryptAES? encryptionDecryptAES,
    Keys? keys,
    KeyRepository? keyRepository,
    DeviceRepository? deviceRepository,
    TokenInterceptorRepository? tokenInterceptorRepository,
    Bytes? bytes,
    DeviceSP? deviceSP,
    KeySP? keySP,
    UserSP? userSP,
    RouteSP? routeSP,
    TokenSP? tokenSP,
  }) {
    final Dio dio = Dio(
      BaseOptions(
        contentType: ContentType.json.toString(),
        connectTimeout: const Duration(seconds: 30),
      ),
    );

    if (keys != null) {
      dio.interceptors.add(
        DioEncryptedInterceptor(
          encryptionDecryptAES: encryptionDecryptAES!,
          keys: keys,
          keyRepository: keyRepository!,
          deviceRepository: deviceRepository!,
          bytes: bytes!,
          tokenSP: tokenSP!,
        ),
      );

      dio.interceptors.add(
        DioDecryptedInterceptor(
          encryptionDecryptAES: encryptionDecryptAES,
          keys: keys,
          keyRepository: keyRepository,
          deviceRepository: deviceRepository,
          bytes: bytes,
          tokenSP: tokenSP,
        ),
      );
    }

    if (tokenInterceptorRepository != null) {
      dio.interceptors.add(DioErrorInterceptor(
        dio: dio,
        tokenInterceptorRepository: tokenInterceptorRepository,
        deviceSP: deviceSP,
        keySP: keySP,
        userSP: userSP,
        routeSP: routeSP,
        tokenSP: tokenSP,
      ));
    }

    return dio;
  }
}
