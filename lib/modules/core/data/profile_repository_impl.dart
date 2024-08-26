import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_profile.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_profile.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_profile.dart';
import 'package:portfolio_flutter/modules/core/data/profile_repository.dart';

import 'network/exceptions/http_exception.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final RestProfile restProfile;

  ProfileRepositoryImpl({required this.restProfile});

  @override
  Future<void> sendProfile(RequestProfile profile) async {
    try {
      await restProfile.requestProfile(profile);
    } on DioException catch (e) {
      throw HttpException(exception: e);
    } on Exception catch (_) {
      throw HttpException(errorEnum: HttpErrorEnum.ERROR_GENERAL);
    }
  }

  @override
  Future<ResponseProfile> getProfile() async {
    try {
      return await restProfile.getProfile();
    } on DioException catch (e) {
      throw HttpException(exception: e);
    } on Exception catch (_) {
      throw HttpException(errorEnum: HttpErrorEnum.ERROR_GENERAL);
    }
  }
}
