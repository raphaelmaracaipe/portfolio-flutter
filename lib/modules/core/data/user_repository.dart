import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';

abstract class UserRepository {
  Future<void> requestCode(RequestUserCode requestUserCode);

  Future<ResponseValidCode> requestValidCode(String code);
}
