import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';

abstract class UserRepository {
  Future<void> requestCode(RequestUserCode requestUserCode);

  Future<void> requestValidCode(String code);

  Future<String> getPhoneRegistredInSP();

  Future<void> savePhoneInSp(String phone);
}
