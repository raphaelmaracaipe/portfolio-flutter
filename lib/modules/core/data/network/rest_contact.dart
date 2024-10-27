import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_contact.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_contact.g.dart';

@RestApi()
abstract class RestContact {
  factory RestContact(Dio dio, {String baseUrl}) = _RestContact;

  @POST("/v1/contacts")
  Future<List<ResponseContact>> consult(
    @Body() List<String> contacts,
  );
}
