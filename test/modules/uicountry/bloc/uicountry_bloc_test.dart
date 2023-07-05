import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_event.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_state.dart';

import 'uicountry_bloc_test.mocks.dart';

class MockCountriesRepository extends Mock implements CountriesRepository {}

@GenerateMocks([MockCountriesRepository])
void main() {
  late UICountryBloc uiCountryBloc;
  late MockMockCountriesRepository mockCountriesRepository;

  List<CountryModel> countries = [
    CountryModel(
      codeCountry: "codeCountry",
      countryName: "countryName",
      codeIson: "codeIson",
      mask: "mask",
    )
  ];

  setUp(() {
    mockCountriesRepository = MockMockCountriesRepository();
    uiCountryBloc = UICountryBloc(countriesRepository: mockCountriesRepository);
  });

  group("UICountryBloc", () {
    blocTest<UICountryBloc, UiCountryBlocState>(
      'when send consult to repository bloc return state loaded',
      build: () {
        when(mockCountriesRepository.readJSON()).thenAnswer(
          (_) async => countries,
        );
        return uiCountryBloc;
      },
      act: (bloc) => bloc.add(GetListOfCountries()),
      expect: () => [
        UiCountryBlocLoading(),
        UiCountryBlocLoaded(countries),
      ],
    );

    blocTest<UICountryBloc, UiCountryBlocState>(
      'when send consult to repository but return empty list',
      build: () {
        when(mockCountriesRepository.readJSON()).thenAnswer(
          (_) async => [],
        );
        return uiCountryBloc;
      },
      act: (bloc) => bloc.add(GetListOfCountries()),
      expect: () => [
        UiCountryBlocLoading(),
        const UiCountryBlocLoaded([]),
      ],
    );

    blocTest<UICountryBloc, UiCountryBlocState>(
      'when send consult to repository but return error',
      build: () {
        when(mockCountriesRepository.readJSON()).thenThrow(Exception("test"));
        return uiCountryBloc;
      },
      act: (bloc) => bloc.add(GetListOfCountries()),
      expect: () => [
        UiCountryBlocLoading(),
        UiCountryBlocError(),
      ],
    );
  });

  tearDown(() {
    uiCountryBloc.close();
  });
}
