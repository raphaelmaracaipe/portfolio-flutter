import 'package:equatable/equatable.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_status.dart';

abstract class UiCountryBlocState extends Equatable {
  final UiCountryBlocStatus _status;
  final List<CountryModel> _countries;

  const UiCountryBlocState({
    required UiCountryBlocStatus status,
    required List<CountryModel> countries,
  })  : _status = status,
        _countries = countries;

  @override
  List<Object> get props => [];

  get status => _status;

  List<CountryModel> get countries => _countries;
}

class UiCountryBlocLoading extends UiCountryBlocState {
  UiCountryBlocLoading()
      : super(
          status: UiCountryBlocStatus.loading,
          countries: [],
        );
}

class UiCountryBlocLoaded extends UiCountryBlocState {
  @override
  final List<CountryModel> countries;

  const UiCountryBlocLoaded(
    this.countries,
  ) : super(
          status: UiCountryBlocStatus.loaded,
          countries: countries,
        );

  @override
  List<Object> get props => [countries];
}

class UiCountryBlocError extends UiCountryBlocState {
  UiCountryBlocError()
      : super(
          status: UiCountryBlocStatus.error,
          countries: [],
        );
}

class UiCountryBlocUnknown extends UiCountryBlocState {
  UiCountryBlocUnknown()
      : super(
          status: UiCountryBlocStatus.unknown,
          countries: [],
        );
}
