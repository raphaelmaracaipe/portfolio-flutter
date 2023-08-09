import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/modules/core/data/hand_shake_repository.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository.dart';
import 'package:portfolio_flutter/modules/core/security/keys.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_event.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_state.dart';

class UiSplashBloc extends Bloc<UiSplashBlocEvent, UiSplashBlocState> {
  final RouteRepository routeRepository;
  final HandShakeRepository handShakeRepository;
  final Keys key;

  UiSplashBloc({
    required this.key,
    required this.routeRepository,
    required this.handShakeRepository,
  }) : super(const UiSplashBlocUnknown()) {
    on<GetRouteSaved>(_getRouteSaved);
    on<SendCodeToServer>(_sendCodeToServer);
  }

  void _getRouteSaved(
    GetRouteSaved event,
    Emitter<UiSplashBlocState> emitter,
  ) async {
    final String routeSaved = await routeRepository.get();
    emitter(UiSplashBlocRoute(routeName: routeSaved));
  }

  FutureOr<void> _sendCodeToServer(
    SendCodeToServer event,
    Emitter<UiSplashBlocState> emitter,
  ) async {
    try {
      await handShakeRepository.send();
      emitter(const UiSplashBlocFinishHandShake());
    } catch (_) {
      emitter(const UiSplashBlocHandShakeError());
    }
  }
}
