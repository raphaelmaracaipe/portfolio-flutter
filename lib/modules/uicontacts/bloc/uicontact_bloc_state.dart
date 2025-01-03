import 'package:equatable/equatable.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';
import 'package:portfolio_flutter/modules/uicontacts/bloc/uicontact_bloc_status.dart';

abstract class UiContactBlocState extends Equatable {
  final List<ContactEntity> _contacts;
  final UiContactBlocStatus _status;

  const UiContactBlocState({
    required List<ContactEntity> contacts,
    required UiContactBlocStatus status,
  })  : _contacts = contacts,
        _status = status;

  @override
  List<Object?> get props => [];

  UiContactBlocStatus get status => _status;

  List<ContactEntity> get contacts => _contacts;
}

class UiContactBlocUnknown extends UiContactBlocState {
  UiContactBlocUnknown()
      : super(
          contacts: [],
          status: UiContactBlocStatus.unknown,
        );
}

class UiContactBlocLoading extends UiContactBlocState {
  UiContactBlocLoading()
      : super(
          contacts: [],
          status: UiContactBlocStatus.loading,
        );
}

class UiContactBlocError extends UiContactBlocState {
  UiContactBlocError()
      : super(
          contacts: [],
          status: UiContactBlocStatus.error,
        );
}

class UiContactBlocPermissionNotGranted extends UiContactBlocState {
  UiContactBlocPermissionNotGranted()
      : super(
          contacts: [],
          status: UiContactBlocStatus.permissionNotGranted,
        );
}

class UiContactBlocSuccess extends UiContactBlocState {
  @override
  final List<ContactEntity> contacts;

  const UiContactBlocSuccess(this.contacts)
      : super(
          contacts: contacts,
          status: UiContactBlocStatus.success,
        );

  @override
  List<Object?> get props => [contacts];
}
