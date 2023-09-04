// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'request_encrypted.g.dart';

@JsonSerializable()
class RequestEncrypted {
  String? data;

  RequestEncrypted({this.data});

  Map<String, dynamic> toJson() => _$RequestEncryptedToJson(this);
}
