abstract class EncryptionDecryptAES {
  Future<dynamic> encryptData({
    required String text,
    required String key,
    required String iv,
  });

  Future<dynamic> decryptData({
    required dynamic encrypted,
    required String key,
    required String iv,
  });
}
