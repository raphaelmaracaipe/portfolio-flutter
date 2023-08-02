import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_event.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_state.dart';

class UiSplashBloc extends Bloc<UiSplashBlocEvent, UiSplashBlocState> {
  final RouteRepository routeRepository;

  UiSplashBloc({
    required this.routeRepository,
  }) : super(const UiSplashBlocUnknown()) {
    on<GetRouteSaved>(_getRouteSaved);
  }

  void _getRouteSaved(
    GetRouteSaved event,
    Emitter<UiSplashBlocState> emitter,
  ) async {
    final String routeSaved = await routeRepository.get();
    emitter(UiSplashBlocRoute(routeName: routeSaved));
  }
}
