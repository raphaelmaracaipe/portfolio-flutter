// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'request_profile.g.dart';

@JsonSerializable()
class RequestProfile {
  String? name;
  String? photo;

  RequestProfile({this.name, this.photo});

  factory RequestProfile.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$RequestProfileFromJson(json);

  Map<String, dynamic> toJson() => _$RequestProfileToJson(this);
}
