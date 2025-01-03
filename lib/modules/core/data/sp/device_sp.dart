abstract class DeviceSP {
  Future<String> getDeviceID();

  Future<void> save(String id);

  Future<void> clean();
}
