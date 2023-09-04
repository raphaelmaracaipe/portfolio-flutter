import 'package:equatable/equatable.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_status.dart';

abstract class UiAuthBlocState extends Equatable {
  final UiAuthBlocStatus _status;
  final List<CountryModel> _countries;
  final bool? _isSuccessToRequestCode;

  const UiAuthBlocState({
    required UiAuthBlocStatus status,
    required List<CountryModel> countries,
    required bool? isSuccessToRequestCode,
  })  : _status = status,
        _countries = countries,
        _isSuccessToRequestCode = isSuccessToRequestCode;

  @override
  List<Object?> get props => [];

  get status => _status;

  List<CountryModel> get countries => _countries;

  get isSuccess => _isSuccessToRequestCode;
}

class UiAuthBlocLoading extends UiAuthBlocState {
  UiAuthBlocLoading()
      : super(
          status: UiAuthBlocStatus.loading,
          countries: [],
          isSuccessToRequestCode: null,
        );
}

class UiAuthBlocLoaded extends UiAuthBlocState {
  @override
  final List<CountryModel> countries;

  const UiAuthBlocLoaded(this.countries)
      : super(
          countries: countries,
          status: UiAuthBlocStatus.loaded,
          isSuccessToRequestCode: null,
        );

  @override
  List<Object> get props => [countries];
}

class UiAuthBlocError extends UiAuthBlocState {
  UiAuthBlocError()
      : super(
          countries: [],
          status: UiAuthBlocStatus.error,
          isSuccessToRequestCode: null,
        );
}

class UiAuthBlocUnknown extends UiAuthBlocState {
  UiAuthBlocUnknown()
      : super(
          countries: [],
          status: UiAuthBlocStatus.unknown,
          isSuccessToRequestCode: null,
        );
}

class UiAuthBlocResponseSendCode extends UiAuthBlocState {
  @override
  final bool isSuccess;

  UiAuthBlocResponseSendCode({required this.isSuccess})
      : super(
          status: UiAuthBlocStatus.codeRequest,
          countries: [],
          isSuccessToRequestCode: isSuccess,
        );
}
