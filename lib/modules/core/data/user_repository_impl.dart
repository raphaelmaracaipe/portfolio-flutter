import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_user.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/user_sp.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';

class UserRepositoryImpl extends UserRepository {
  final RestUser restClient;
  final TokenSP tokenSP;
  final UserSP userSP;

  UserRepositoryImpl({
    required this.restClient,
    required this.tokenSP,
    required this.userSP,
  });

  @override
  Future<void> requestCode(
    RequestUserCode requestUserCode,
  ) async =>
      await restClient.requestCode(requestUserCode);

  @override
  Future<void> requestValidCode(
    String code,
  ) async {
    try {
      final responseValidCode = await restClient.requestValidCode(code);
      tokenSP.save(responseValidCode);
    } on DioException catch (e) {
      throw HttpException(exception: e);
    } on Exception catch (_) {
      throw HttpException(errorEnum: HttpErrorEnum.ERROR_GENERAL);
    }
  }

  @override
  Future<String> getPhoneRegistredInSP() async {
    return await userSP.getPhone();
  }

  @override
  Future<void> savePhoneInSp(String phone) async {
    await userSP.savePhone(phone);
  }
}
