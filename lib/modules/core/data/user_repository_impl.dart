import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_client.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';

class UserRepositoryImpl extends UserRepository {
  late final RestClient _restClient;

  UserRepositoryImpl({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<void> requestCode(
    RequestUserCode requestUserCode,
  ) async =>
      await _restClient.requestCode(requestUserCode);

  @override
  Future<ResponseValidCode> requestValidCode(
    String code,
  ) async {
    try {
      return await _restClient.requestValidCode(code);
    } on DioException catch (e) {
      throw HttpException(e);
    }
  }
}
