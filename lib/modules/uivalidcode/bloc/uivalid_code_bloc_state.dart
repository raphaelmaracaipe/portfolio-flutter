import 'package:equatable/equatable.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_status.dart';

abstract class UiValidCodeBlocState extends Equatable {
  final UiValidCodeBlocStatus _status;
  final ResponseValidCode? _response;
  final HttpErrorEnum _codeError;

  const UiValidCodeBlocState({
    required UiValidCodeBlocStatus status,
    required HttpErrorEnum codeError,
    ResponseValidCode? response,
  })  : _status = status,
        _codeError = codeError,
        _response = response;

  UiValidCodeBlocStatus get status => _status;

  HttpErrorEnum get codeError => _codeError;

  @override
  List<Object?> get props => [];
}

class UiValidCodeBlocUnknown extends UiValidCodeBlocState {
  const UiValidCodeBlocUnknown()
      : super(
          status: UiValidCodeBlocStatus.unknown,
          codeError: HttpErrorEnum.UNKNOWN,
        );
}

class UiValidCodeBlocLoading extends UiValidCodeBlocState {
  const UiValidCodeBlocLoading()
      : super(
          status: UiValidCodeBlocStatus.loading,
          codeError: HttpErrorEnum.UNKNOWN,
        );
}

class UiValidCodeBlocError extends UiValidCodeBlocState {
  final HttpErrorEnum codeError;

  const UiValidCodeBlocError({required this.codeError})
      : super(
          status: UiValidCodeBlocStatus.error,
          codeError: codeError,
        );
}

class UiValidCodeBlocLoaded extends UiValidCodeBlocState {
  final ResponseValidCode response;
  const UiValidCodeBlocLoaded({required this.response})
      : super(
          status: UiValidCodeBlocStatus.loaded,
          response: response,
          codeError: HttpErrorEnum.UNKNOWN,
        );
}

class UiValidCodeBlocCleanRoute extends UiValidCodeBlocState {
  const UiValidCodeBlocCleanRoute()
      : super(
          status: UiValidCodeBlocStatus.cleanRoute,
          codeError: HttpErrorEnum.UNKNOWN,
        );
}
