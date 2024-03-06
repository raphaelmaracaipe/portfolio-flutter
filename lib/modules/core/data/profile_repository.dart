import 'package:portfolio_flutter/modules/core/data/network/request/request_profile.dart';

abstract class ProfileRepository {
  Future<void> sendProfile(RequestProfile profile);
}
