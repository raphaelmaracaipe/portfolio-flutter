import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/config/app_route.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_event.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_state.dart';

class UiValidCodeBloc extends Bloc<UiValidCodeBlocEvent, UiValidCodeBlocState> {
  late final UserRepository _userRepository;
  late final RouteRepository _routeRepository;

  UiValidCodeBloc({
    required UserRepository userRepository,
    required RouteRepository routeRepository,
  }) : super(const UiValidCodeBlocUnknown()) {
    _userRepository = userRepository;
    _routeRepository = routeRepository;

    on<SendCodeToValidationEvent>(_onSendToValidationOfCode);
    on<CleanRouteSavedEvent>(_onCleanRouteSavedEvent);
  }

  void _onSendToValidationOfCode(
    SendCodeToValidationEvent event,
    Emitter<UiValidCodeBlocState> emitter,
  ) async {
    emitter(const UiValidCodeBlocLoading());
    try {
      final ResponseValidCode response = await _userRepository.requestValidCode(
        event.code,
      );
      await _routeRepository.save(AppRoute.uIProfile);

      emitter(UiValidCodeBlocLoaded(response: response));
    } on HttpException catch (e) {
      emitter(UiValidCodeBlocError(codeError: e.enumError));
    }
  }

  void _onCleanRouteSavedEvent(
    event,
    Emitter<UiValidCodeBlocState> emitter,
  ) async {
    emitter(const UiValidCodeBlocLoading());
    await _routeRepository.clean();
    emitter(const UiValidCodeBlocCleanRoute());
  }
}
