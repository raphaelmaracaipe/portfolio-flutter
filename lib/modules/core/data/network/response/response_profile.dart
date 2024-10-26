// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'response_profile.g.dart';

@JsonSerializable()
class ResponseProfile {
  String? name;
  String? photo;
  String? reminder;

  ResponseProfile({
    this.name,
    this.photo,
    this.reminder,
  });

  factory ResponseProfile.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ResponseProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseProfileToJson(this);
}
