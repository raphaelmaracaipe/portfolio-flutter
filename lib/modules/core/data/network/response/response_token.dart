// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'response_token.g.dart';

@JsonSerializable()
class ResponseToken {
  String? refreshToken;
  String? accessToken;

  ResponseToken({this.refreshToken, this.accessToken});

  factory ResponseToken.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ResponseTokenFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseTokenToJson(this);
}
