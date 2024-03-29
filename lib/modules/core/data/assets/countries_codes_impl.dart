import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';

class CountriesCodeImpl extends CountriesCode {
  final AssetBundle assetBundle;

  CountriesCodeImpl({required this.assetBundle});

  @override
  Future<List<CountryModel>> readJSON() async {
    String jsonData = await assetBundle.loadString('assets/json/codes.json');
    return (json.decode(jsonData) as List<dynamic>)
        .map((jsonItem) => CountryModel.fromJSON(jsonItem))
        .toList();
  }
}
