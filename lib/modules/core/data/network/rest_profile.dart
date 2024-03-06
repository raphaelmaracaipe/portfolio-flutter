import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_profile.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_profile.g.dart';

@RestApi()
abstract class RestProfile {
  factory RestProfile(Dio dio, {String baseUrl}) = _RestProfile;

  @POST("/v1/users/profile")
  Future<void> requestProfile(@Body() RequestProfile requestProfile);
}
