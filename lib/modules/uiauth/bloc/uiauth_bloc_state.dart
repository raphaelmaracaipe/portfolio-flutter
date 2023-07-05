import 'package:equatable/equatable.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_status.dart';

abstract class UiAuthBlocState extends Equatable {
  final UiAuthBlocStatus _status;
  final List<CountryModel> _countries;

  const UiAuthBlocState({
    required UiAuthBlocStatus status,
    required List<CountryModel> countries,
  })  : _status = status,
        _countries = countries;

  @override
  List<Object?> get props => [];

  get status => _status;

  List<CountryModel> get countries => _countries;
}

class UiAuthBlocLoading extends UiAuthBlocState {
  UiAuthBlocLoading()
      : super(
          status: UiAuthBlocStatus.loading,
          countries: [],
        );
}

class UiAuthBlocLoaded extends UiAuthBlocState {
  @override
  final List<CountryModel> countries;

  const UiAuthBlocLoaded(this.countries)
      : super(
          countries: countries,
          status: UiAuthBlocStatus.loaded,
        );

  @override
  List<Object> get props => [countries];
}

class UiAuthBlocError extends UiAuthBlocState {
  UiAuthBlocError() : super(countries: [], status: UiAuthBlocStatus.error);
}

class UiAuthBlocUnknown extends UiAuthBlocState {
  UiAuthBlocUnknown() : super(countries: [], status: UiAuthBlocStatus.unknown);
}
