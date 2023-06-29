import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';

abstract class CountriesRepository {
  Future<List<CountryModel>> readJSON();
}