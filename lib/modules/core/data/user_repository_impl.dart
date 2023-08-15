import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_user.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';

class UserRepositoryImpl extends UserRepository {
  final RestUser restClient;
  UserRepositoryImpl({
    required this.restClient
  });

  @override
  Future<void> requestCode(
    RequestUserCode requestUserCode,
  ) async =>
      await restClient.requestCode(requestUserCode);

  @override
  Future<ResponseValidCode> requestValidCode(
    String code,
  ) async {
    try {
      return await restClient.requestValidCode(code);
    } on DioException catch (e) {
      throw HttpException(exception: e);
    } on Exception catch (_) {
      throw HttpException(errorEnum: HttpErrorEnum.ERROR_GENERAL);
    }
  }
}
