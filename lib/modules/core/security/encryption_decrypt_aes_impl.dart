import 'package:flutter/services.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';

class EncryptionDecryptAESImpl extends EncryptionDecryptAES {
  final MethodChannel encryptionChannel;
  EncryptionDecryptAESImpl({
    required this.encryptionChannel,
  });

  // final MethodChannel _encryptionChannel = const MethodChannel(
  //   'com.example.portfolio_flutter/encdesc',
  // );

  @override
  Future decryptData(dynamic encrypted, String key) async {
    try {
      return await encryptionChannel.invokeMethod('decrypt', {
        'data': encrypted,
        'key': key,
      });
    } on PlatformException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future encryptData(String encrypted, String key) async {
    try {
      return await encryptionChannel.invokeMethod(
        'encrypt',
        {
          'data': encrypted,
          'key': key,
        },
      );
    } on PlatformException catch (e) {
      throw Exception(e.message);
    }
  }
}
