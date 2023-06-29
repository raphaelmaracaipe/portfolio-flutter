import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';

abstract class CountriesCode {
  Future<List<CountryModel>> readJSON();
}