import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';

void main() {
  test('when put values to model and get json string', () async {
    final CountryModel countryModel = CountryModel(
      codeCountry: "AAA",
      countryName: "BBB",
      codeIson: "CCC",
      mask: "DDD",
    );

    String json = countryModel.toJSONString();
    expect(true, json.contains('"code_ison":"CCC"'));
  });
}
