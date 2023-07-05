import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_event.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_state.dart';

import 'uiauth_bloc_test.mocks.dart';

class MockCountriesRepository extends Mock implements CountriesRepository {}

@GenerateMocks([MockCountriesRepository])
void main() {
  late UiAuthBloc uiAuthBloc;
  late MockMockCountriesRepository mockCountriesRepository;

  List<CountryModel> countries = [
    CountryModel(
      codeCountry: "codeCountry2",
      countryName: "countryName2",
      codeIson: "codeIson2",
      mask: "mask2",
    )
  ];

  setUp(() {
    mockCountriesRepository = MockMockCountriesRepository();
    uiAuthBloc = UiAuthBloc(countriesRepository: mockCountriesRepository);
  });

  group("UiAuthBloc", () {
    blocTest<UiAuthBloc, UiAuthBlocState>(
      'when send consult to repository bloc return state loaded',
      build: () {
        when(mockCountriesRepository.readJSON()).thenAnswer(
          (_) async => countries,
        );
        return uiAuthBloc;
      },
      act: (bloc) => bloc.add(GetListOfCountriesInAuth()),
      expect: () => [
        UiAuthBlocLoading(),
        UiAuthBlocLoaded(countries),
      ],
    );

    blocTest<UiAuthBloc, UiAuthBlocState>(
      'when send consult to repository but return empty list',
      build: () {
        when(mockCountriesRepository.readJSON()).thenAnswer((_) async => []);
        return uiAuthBloc;
      },
      act: (bloc) => bloc.add(GetListOfCountriesInAuth()),
      expect: () => [
        UiAuthBlocLoading(),
        const UiAuthBlocLoaded([]),
      ],
    );

    blocTest<UiAuthBloc, UiAuthBlocState>(
      'when send consult to repository but return error',
      build: () {
        when(mockCountriesRepository.readJSON()).thenThrow(
          Exception("test error"),
        );
        return uiAuthBloc;
      },
      act: (bloc) => bloc.add(GetListOfCountriesInAuth()),
      expect: () => [
        UiAuthBlocLoading(),
        UiAuthBlocError(),
      ],
    );
  });

  tearDown(() {
    uiAuthBloc.close();
  });
}
