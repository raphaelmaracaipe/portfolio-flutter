import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_client.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl extends UserRepository {
  late final RestClient _restClient;
  late final Future<SharedPreferences> _sp;

  final _typeScreenKey = 'TYPESCREEN_KEY';

  UserRepositoryImpl({
    required RestClient restClient,
    required Future<SharedPreferences> sharedPreferences,
  })  : _restClient = restClient,
        _sp = sharedPreferences;

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

  @override
  Future<void> saveRoute(String typeScreen) async {
    final SharedPreferences sp = await _sp;
    await sp.setString(_typeScreenKey, typeScreen);
  }

  @override
  Future<String> getRouteSaved() async {
    final SharedPreferences sp = await _sp;
    return sp.getString(_typeScreenKey) ?? "";
  }

  @override
  Future<void> cleanRouteSaved() async {
    final SharedPreferences sp = await _sp;
    sp.remove(_typeScreenKey);
  }
}
