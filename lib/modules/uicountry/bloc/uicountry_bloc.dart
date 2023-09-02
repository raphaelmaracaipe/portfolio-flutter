import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_event.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_state.dart';

@Injectable()
class UICountryBloc extends Bloc<UiCountryBlocEvent, UiCountryBlocState> {
  late final CountriesRepository _countriesRepository;

  UICountryBloc({required CountriesRepository countriesRepository})
      : super(UiCountryBlocUnknown()) {
    _countriesRepository = countriesRepository;
    on<GetListOfCountriesInCountry>(_onGetListOfCountries);
  }

  void _onGetListOfCountries(
    GetListOfCountriesInCountry event,
    Emitter<UiCountryBlocState> emitter,
  ) async {
    emitter(UiCountryBlocLoading());
    try {
      List<CountryModel> countries = await _countriesRepository.readJSON();
      emitter(UiCountryBlocLoaded(countries));
    } on Exception catch (_) {
      emitter(UiCountryBlocError());
    }
  }
}
