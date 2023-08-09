import 'package:json_annotation/json_annotation.dart';

part 'request_hand_shake.g.dart';

@JsonSerializable()
class RequestHandShake {
  String? key;

  RequestHandShake({this.key});

  Map<String, dynamic> toJson() => _$RequestHandShakeToJson(this);
}