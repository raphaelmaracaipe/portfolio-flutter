import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes_impl.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';

import 'countries_codes_test.mocks.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

@GenerateMocks([MockAssetBundle])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('when request list of countries with codes', () async {
    List<CountryModel> countries = [
      CountryModel(
        codeCountry: "AAA",
        countryName: "BBB",
        codeIson: "CCC",
        mask: "DDD",
      ),
    ];

    List<Map<String, dynamic>> countriesMap = countries
        .map(
          (country) => country.toJSON(),
        )
        .toList();

    final MockMockAssetBundle mockMockAssetBundle = MockMockAssetBundle();
    when(mockMockAssetBundle.loadString('assets/json/codes.json')).thenAnswer(
      (_) async => jsonEncode(countriesMap),
    );

    final CountriesCode countriesCode = CountriesCodeImpl(
      assetBundle: mockMockAssetBundle,
    );

    List<CountryModel> countriesReturn = await countriesCode.readJSON();
    expect(countriesReturn.length, 1);
  });
}
