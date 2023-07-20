import 'package:json_annotation/json_annotation.dart';

part 'response_valid_code.g.dart';

@JsonSerializable()
class ResponseValidCode {
  String? refreshToken;
  String? accessToken;

  ResponseValidCode({this.refreshToken, this.accessToken});

  factory ResponseValidCode.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ResponseValidCodeFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseValidCodeToJson(this);
}
