import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_token.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_token.dart';
import 'package:retrofit/http.dart';

part 'rest_token.g.dart';

@RestApi()
abstract class RestToken {
  factory RestToken(Dio dio, {String baseUrl}) = _RestToken;

  @POST("/v1/tokens/refresh")
  Future<ResponseToken> updateToken(@Body() RequestToken requestToken);
}
