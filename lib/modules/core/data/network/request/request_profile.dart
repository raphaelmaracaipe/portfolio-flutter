// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'request_profile.g.dart';

@JsonSerializable()
class RequestProfile {
  String? name;
  String? photo;
  String? reminder;

  RequestProfile({
    this.name,
    this.photo,
    this.reminder,
  });

  factory RequestProfile.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$RequestProfileFromJson(json);

  Map<String, dynamic> toJson() => _$RequestProfileToJson(this);
}
