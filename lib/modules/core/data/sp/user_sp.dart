abstract class UserSP {
  Future<void> savePhone(String phone);

  Future<String> getPhone();

  Future<void> clean();
}