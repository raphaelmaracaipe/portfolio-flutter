abstract class KeyRepository {

  Future<void> cleanSeedSaved();

  Future<String> getKey();

  Future<String> getSeed();

}