import 'package:dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_token.dart';

import 'package:retrofit/retrofit.dart';

part 'rest_user.g.dart';

@RestApi()
abstract class RestUser {
  factory RestUser(Dio dio, {String baseUrl}) = _RestUser;

  @POST("/v1/users/code")
  Future<void> requestCode(@Body() RequestUserCode requestUserCode);

  @GET("/v1/users/valid")
  Future<ResponseToken> requestValidCode(@Query('code') String code);
}
