import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_hand_shake.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_hand_shake.g.dart';

@RestApi()
abstract class RestHandShake {
  factory RestHandShake(Dio dio, {String baseUrl}) = _RestHandShake;

  @POST("/v1/handshake/")
  Future<void> requestHandShake(@Body() RequestHandShake request);
}
