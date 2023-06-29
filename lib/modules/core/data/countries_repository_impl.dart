import 'package:portfolio_flutter/modules/core/data/assets/countries_codes.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';

class CountriesRepositoryImpl extends CountriesRepository {
  late final CountriesCode _countriesCode;

  CountriesRepositoryImpl({
    required CountriesCode countriesCode,
  }) : _countriesCode = countriesCode;

  @override
  Future<List<CountryModel>> readJSON() async => await _countriesCode.readJSON();
}
