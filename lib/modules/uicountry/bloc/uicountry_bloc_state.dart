import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_status.dart';

class UiCountryBlocState {
  final UiCountryBlocStatus status;
  final List<CountryModel> countries;

  const UiCountryBlocState._({
    this.status = UiCountryBlocStatus.unknown,
    this.countries = const [],
  });

  const UiCountryBlocState.unknown() : this._();

  const UiCountryBlocState.loading()
      : this._(status: UiCountryBlocStatus.loading);

  const UiCountryBlocState.loaded(List<CountryModel> lisOfCountry)
      : this._(
          status: UiCountryBlocStatus.loaded,
          countries: lisOfCountry,
        );

  const UiCountryBlocState.error() : this._(status: UiCountryBlocStatus.error);
}
