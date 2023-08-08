import 'package:flutter/services.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';

class EncryptionDecryptAESImpl extends EncryptionDecryptAES {
  final MethodChannel encryptionChannel;

  EncryptionDecryptAESImpl({
    required this.encryptionChannel,
  });

  @override
  Future decryptData({
    required dynamic encrypted,
    required String key,
    required String iv,
  }) async {
    try {
      return await encryptionChannel.invokeMethod('decrypt', {
        'data': encrypted,
        'key': key,
        'iv': iv,
      });
    } on PlatformException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future encryptData({
    required String text,
    required String key,
    required String iv,
  }) async {
    try {
      return await encryptionChannel.invokeMethod(
        'encrypt',
        {
          'data': text,
          'key': key,
          'iv': iv,
        },
      );
    } on PlatformException catch (e) {
      throw Exception(e.message);
    }
  }
}
