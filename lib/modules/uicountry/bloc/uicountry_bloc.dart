import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_event.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_state.dart';

class UICountryBloc extends Bloc<UiCountryBlocEvent, UiCountryBlocState> {
  late final CountriesRepository _countriesRepository;

  UICountryBloc({required CountriesRepository countriesRepository})
      : super(const UiCountryBlocState.unknown()) {
    _countriesRepository = countriesRepository;
    on<GetListOfCountries>(_onGetListOfCountries);
  }

  void _onGetListOfCountries(
    GetListOfCountries event,
    Emitter<UiCountryBlocState> emitter,
  ) async {
    emitter(const UiCountryBlocState.loading());
    try {
      List<CountryModel> countries = await _countriesRepository.readJSON();
      emitter(UiCountryBlocState.loaded(countries));
    } catch (_) {
      emitter(const UiCountryBlocState.error());
    }
  }
}
