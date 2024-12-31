import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
// ignore: must_be_immutable
class ContactEntity extends Equatable {
  @primaryKey
  String? phone;
  String? name;
  String? photo;
  String? reminder;
  int? lastOnline;

  ContactEntity({
    required this.phone,
    this.photo,
    this.name,
    this.reminder,
    this.lastOnline,
  });

  @override
  List<Object?> get props => [
        name,
        photo,
        phone,
        lastOnline,
      ];
}
