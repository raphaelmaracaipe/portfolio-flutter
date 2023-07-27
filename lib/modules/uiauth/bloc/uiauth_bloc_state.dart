import 'package:equatable/equatable.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_status.dart';

abstract class UiAuthBlocState extends Equatable {
  final UiAuthBlocStatus _status;
  final List<CountryModel> _countries;
  final bool? _isSuccessToRequestCode;
  final String _changeToRoute;

  const UiAuthBlocState({
    required UiAuthBlocStatus status,
    required List<CountryModel> countries,
    required String changeToRoute,
    required bool? isSuccessToRequestCode,
  })  : _status = status,
        _countries = countries,
        _isSuccessToRequestCode = isSuccessToRequestCode,
        _changeToRoute = changeToRoute;

  @override
  List<Object?> get props => [];

  get status => _status;

  List<CountryModel> get countries => _countries;

  get isSuccess => _isSuccessToRequestCode;

  String get navigateToRoute => _changeToRoute;
}

class UiAuthBlocLoading extends UiAuthBlocState {
  UiAuthBlocLoading()
      : super(
          status: UiAuthBlocStatus.loading,
          countries: [],
          isSuccessToRequestCode: null,
          changeToRoute: '',
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
          changeToRoute: '',
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
          changeToRoute: '',
        );
}

class UiAuthBlocUnknown extends UiAuthBlocState {
  UiAuthBlocUnknown()
      : super(
          countries: [],
          status: UiAuthBlocStatus.unknown,
          isSuccessToRequestCode: null,
          changeToRoute: '',
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
          changeToRoute: '',
        );
}

class UiAuthBlocchangeRoute extends UiAuthBlocState {
  final String changeToRoute;

  UiAuthBlocchangeRoute({required this.changeToRoute})
      : super(
          countries: [],
          status: UiAuthBlocStatus.changeRoute,
          isSuccessToRequestCode: null,
          changeToRoute: changeToRoute,
        );
}
