import 'package:json_annotation/json_annotation.dart';

part 'request_valid_code.g.dart';

@JsonSerializable()
class RequestValidCode {
  String? code;

  RequestValidCode({this.code});

  factory RequestValidCode.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$RequestValidCodeFromJson(json);

  Map<String, dynamic> toJson() => _$RequestValidCodeToJson(this);
}
