import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_user.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_event.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_state.dart';

import 'uiauth_bloc_test.mocks.dart';

class CountriesRepositoryMock extends Mock implements CountriesRepository {}

class UserRepositoryMock extends Mock implements UserRepository {}

class RouteRepositoryMock extends Mock implements RouteRepository {}

class RestClientMock extends Mock implements RestUser {}

@GenerateMocks([
  CountriesRepositoryMock,
  UserRepositoryMock,
  RestClientMock,
  RouteRepositoryMock
])
void main() {
  late UiAuthBloc uiAuthBloc;
  late MockCountriesRepositoryMock countriesRepositoryMock;
  late MockUserRepositoryMock userRepositoryMock;
  late MockRouteRepositoryMock routeRepositoryMock;
  late MockRestClientMock restClientMock;

  List<CountryModel> countries = [
    CountryModel(
      codeCountry: "codeCountry2",
      countryName: "countryName2",
      codeIson: "codeIson2",
      mask: "mask2",
    )
  ];

  setUp(() {
    countriesRepositoryMock = MockCountriesRepositoryMock();
    userRepositoryMock = MockUserRepositoryMock();
    routeRepositoryMock = MockRouteRepositoryMock();
    restClientMock = MockRestClientMock();

    uiAuthBloc = UiAuthBloc(
      countriesRepository: countriesRepositoryMock,
      userRepository: userRepositoryMock,
      routeRepository: routeRepositoryMock,
    );
  });

  blocTest<UiAuthBloc, UiAuthBlocState>(
    'when send consult to repository bloc return state loaded',
    build: () {
      when(countriesRepositoryMock.readJSON()).thenAnswer(
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
      when(countriesRepositoryMock.readJSON()).thenAnswer((_) async => []);
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
      when(countriesRepositoryMock.readJSON()).thenThrow(
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

  blocTest<UiAuthBloc, UiAuthBlocState>(
    'when send code phone to server and api return success',
    build: () {
      when(restClientMock.requestCode(any)).thenAnswer(
        (_) async => Future.value,
      );
      return uiAuthBloc;
    },
    act: (bloc) => bloc.add(SendToRequestCode(phoneNumber: "1234567890")),
    expect: () => [
      UiAuthBlocLoading(),
      UiAuthBlocResponseSendCode(isSuccess: true),
    ],
  );

  blocTest<UiAuthBloc, UiAuthBlocState>(
    'when send code phone to server and api return error',
    build: () {
      when(restClientMock.requestCode(any)).thenAnswer((_) async => []);
      return uiAuthBloc;
    },
    act: (bloc) => bloc.add(SendToRequestCode(phoneNumber: "1234567890")),
    expect: () => [
      UiAuthBlocLoading(),
      UiAuthBlocResponseSendCode(isSuccess: false),
    ],
  );

  tearDown(() {
    uiAuthBloc.close();
  });
}
