import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/config/app_key.dart';
import 'package:portfolio_flutter/modules/core/data/device_repository.dart';
import 'package:portfolio_flutter/modules/core/data/key_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
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

  DioEncryptedInterceptor({
    required this.encryptionDecryptAES,
    required this.keys,
    required this.keyRepository,
    required this.deviceRepository,
    required this.bytes,
    required this.tokenSP,
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

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final Map<String, dynamic> responseData = err.response?.data ?? Map.of({});
    if (responseData["statusCode"] == 401 &&
        responseData["message"] == HttpErrorEnum.TOKEN_INVALID.code) {
      print("a");
    }
    super.onError(err, handler);
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

  Future<void> _encryptDataToSendInBody(
    RequestOptions options,
    String iv,
  ) async {
    final String bodyEncrypted = await encryptionDecryptAES.encryptData(
      text: json.encode(options.data),
      key: await _getKey(),
      iv: iv,
    );

    options.data = RequestEncrypted(
      data: Uri.encodeComponent(bodyEncrypted),
    ).toJson();
  }

  Future<String> _getKey() async {
    final String keySaved = await keyRepository.getKey();
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
