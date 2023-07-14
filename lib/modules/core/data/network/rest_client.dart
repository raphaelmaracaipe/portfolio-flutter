import 'package:dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/v1/users/code")
  Future<void> requestCode(@Body() RequestUserCode requestUserCode);
}
