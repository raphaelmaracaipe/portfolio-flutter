import 'package:json_annotation/json_annotation.dart';

part 'request_user_code.g.dart';

@JsonSerializable()
class RequestUserCode {
  String? phone;

  RequestUserCode({this.phone});

  factory RequestUserCode.fromJson(
    Map<String, dynamic> json,
  ) => _$RequestUserCodeFromJson(json);

  Map<String, dynamic> toJson() => _$RequestUserCodeToJson(this);
}
