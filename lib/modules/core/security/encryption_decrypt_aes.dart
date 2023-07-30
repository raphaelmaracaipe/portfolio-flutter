abstract class EncryptionDecryptAES {
  Future<dynamic> encryptData(String encrypted, String key);

  Future<dynamic> decryptData(dynamic encrypted, String key);
}
