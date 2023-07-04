import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository_impl.dart';

import 'countries_repository_test.mocks.dart';

class MockCountriesCode extends Mock implements CountriesCode {}

@GenerateMocks([MockCountriesCode])
void main() {
  group('CountriesRepository', () {
    test('when request list of countries', () async {
      List<CountryModel> countries = [
        CountryModel(
          codeCountry: "AAA",
          countryName: "BBB",
          codeIson: "CCC",
          mask: "DDD",
        )
      ];

      MockMockCountriesCode mockMockCountriesCode = MockMockCountriesCode();
      when(mockMockCountriesCode.readJSON()).thenAnswer((_) async => countries);

      CountriesRepository countriesRepository = CountriesRepositoryImpl(
        countriesCode: mockMockCountriesCode,
      );

      List<CountryModel> countriesReturn = await countriesRepository.readJSON();
      expect(countriesReturn[0].codeCountry, countries[0].codeCountry);
    });
  });
}
