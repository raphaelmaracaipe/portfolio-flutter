import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class ContactEntity extends Equatable {
  @primaryKey
  String? phone;
  String? name;
  String? photo;
  String? status;

  ContactEntity({
    required this.phone,
    this.photo,
    this.name,
    this.status
  });

  @override
  List<Object?> get props => [name, photo, phone];
}
