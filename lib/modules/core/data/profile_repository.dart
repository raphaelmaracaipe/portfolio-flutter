import 'package:portfolio_flutter/modules/core/data/network/request/request_profile.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_profile.dart';

abstract class ProfileRepository {
  Future<void> sendProfile(RequestProfile profile);

  Future<ResponseProfile> getProfile();
}
