import 'package:equatable/equatable.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc_status.dart';

abstract class UiProfileBlocState extends Equatable {
  final UiProfileBlocStatus status;

  const UiProfileBlocState({required this.status});

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
