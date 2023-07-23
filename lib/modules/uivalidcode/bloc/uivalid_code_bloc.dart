import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_event.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_state.dart';

class UiValidCodeBloc extends Bloc<UiValidCodeBlocEvent, UiValidCodeBlocState> {
  late final UserRepository _userRepository;

  UiValidCodeBloc({
    required UserRepository userRepository,
  }) : super(const UiValidCodeBlocUnknown()) {
    _userRepository = userRepository;

    on<SendCodeToValidationEvent>(_onSendToValidationOfCode);
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

      emitter(UiValidCodeBlocLoaded(response: response));
    } on HttpException catch (e) {
      emitter(UiValidCodeBlocError(codeError: e.enumError));
    }
  }
}
