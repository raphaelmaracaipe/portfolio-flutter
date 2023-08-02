abstract class EncryptionDecryptAES {
  Future<dynamic> encryptData({required String text, required String key});

  Future<dynamic> decryptData({required dynamic encrypted, required String key});
}
