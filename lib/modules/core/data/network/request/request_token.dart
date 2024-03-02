// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'request_token.g.dart';

@JsonSerializable()
class RequestToken {
  String? refresh;

  RequestToken({required this.refresh});

  factory RequestToken.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$RequestTokenFromJson(json);

  Map<String, dynamic> toJson() => _$RequestTokenToJson(this);
}
