import 'package:equatable/equatable.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_profile.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc_status.dart';

abstract class UiProfileBlocState extends Equatable {
  final UiProfileBlocStatus status;
  final ResponseProfile? _responseProfile;

  const UiProfileBlocState({
    required this.status,
    ResponseProfile? responseProfile,
  }) : _responseProfile = responseProfile;

  ResponseProfile? get responseProfile => _responseProfile;

  @override
  List<Object?> get props => [];
}

class UiProfileBlocStateUknown extends UiProfileBlocState {
  const UiProfileBlocStateUknown()
      : super(
          status: UiProfileBlocStatus.unknown,
        );
}

class UiProfileBlocStateLoading extends UiProfileBlocState {
  const UiProfileBlocStateLoading()
      : super(
          status: UiProfileBlocStatus.loading,
        );
}

class UiProfileBlocStateUpdateSuccess extends UiProfileBlocState {
  const UiProfileBlocStateUpdateSuccess()
      : super(
          status: UiProfileBlocStatus.updateWithSuccess,
        );
}

class UiProfileBlocStateError extends UiProfileBlocState {
  const UiProfileBlocStateError()
      : super(
          status: UiProfileBlocStatus.error,
        );
}

class UiProfileBlocStateProfileSaved extends UiProfileBlocState {
  @override
  final ResponseProfile responseProfile;

  const UiProfileBlocStateProfileSaved({required this.responseProfile})
      : super(
          status: UiProfileBlocStatus.profileSaved,
        );
}
