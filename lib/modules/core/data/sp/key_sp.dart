abstract class KeySP {
  Future<bool> isExistKeyAndIVSaved();

  Future<void> saveKey(String key);

  Future<void> saveSeed(String seed);

  Future<String> getKey();

  Future<String> getSeed();
}