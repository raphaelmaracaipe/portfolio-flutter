import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_event.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_state.dart';

class UiAuthBloc extends Bloc<UiAuthBlocEvent, UiAuthBlocState> {
  late final CountriesRepository _countriesRepository;

  UiAuthBloc({
    required CountriesRepository countriesRepository,
  }) : super(UiAuthBlocUnknown()) {
    _countriesRepository = countriesRepository;
    on<GetListOfCountriesInAuth>(_onGetListOfCountries);
  }

  void _onGetListOfCountries(
    GetListOfCountriesInAuth event,
    Emitter<UiAuthBlocState> emitter,
  ) async {
    emitter(UiAuthBlocLoading());
    try {
      List<CountryModel> countries = await _countriesRepository.readJSON();
      emitter(UiAuthBlocLoaded(countries));
    } catch (_) {
      emitter(UiAuthBlocError());
    }
  }
}
