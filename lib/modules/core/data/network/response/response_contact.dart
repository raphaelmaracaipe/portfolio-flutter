// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'response_contact.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class ResponseContact extends Equatable {
  String? name;
  String? photo;
  String? phone;

  ResponseContact({
    this.name,
    this.phone,
    this.photo,
  });

  factory ResponseContact.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ResponseContactFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseContactToJson(this);

  @override
  List<Object?> get props => [name, photo, phone];
}
