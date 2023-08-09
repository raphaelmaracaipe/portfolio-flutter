import 'package:equatable/equatable.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_status.dart';

abstract class UiSplashBlocState extends Equatable {
  final UiSplashBlocStatus status;
  final String routeName;

  const UiSplashBlocState({
    required this.status,
    this.routeName = '',
  });

  String get route => routeName;

  @override
  List<Object?> get props => [];
}

class UiSplashBlocUnknown extends UiSplashBlocState {
  const UiSplashBlocUnknown() : super(status: UiSplashBlocStatus.unknown);
}

class UiSplashBlocRoute extends UiSplashBlocState {
  final String routeName;

  const UiSplashBlocRoute({required this.routeName})
      : super(
          status: UiSplashBlocStatus.getRoute,
          routeName: routeName,
        );
}

class UiSplashBlocFinishHandShake extends UiSplashBlocState {
  const UiSplashBlocFinishHandShake()
      : super(
          status: UiSplashBlocStatus.finishHandShake,
        );
}
