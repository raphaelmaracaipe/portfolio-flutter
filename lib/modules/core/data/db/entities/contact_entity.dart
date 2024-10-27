import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class ContactEntity extends Equatable {
  @primaryKey
  String? phone;
  String? name;
  String? photo;
  String? reminder;

  ContactEntity({
    required this.phone,
    this.photo,
    this.name,
    this.reminder
  });

  @override
  List<Object?> get props => [name, photo, phone];
}
