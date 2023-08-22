import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';
import 'package:portfolio_flutter/config/app_route.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/uiauth/uiauth_module.dart';
import 'package:portfolio_flutter/modules/uiauth/uiauth_pages.dart';

import 'uiauth_pages_test.mocks.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

class UserRepositoryMock extends Mock implements UserRepository {}

class CountriesRepositoryMock extends Mock implements CountriesRepository {}

class RouteRepositoryMock extends Mock implements RouteRepository {}

@GenerateMocks([
  ModularNavigateMock,
  UserRepositoryMock,
  CountriesRepositoryMock,
  RouteRepositoryMock,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late UiAuthPage uiAuthPage;
  late MockUserRepositoryMock userRepositoryMock;
  late MockCountriesRepositoryMock countriesRepositoryMock;
  late MockRouteRepositoryMock routeRepositoryMock;
  late MockModularNavigateMock modularNavigateMock;

  setUp(() {
    userRepositoryMock = MockUserRepositoryMock();
    countriesRepositoryMock = MockCountriesRepositoryMock();
    routeRepositoryMock = MockRouteRepositoryMock();
    modularNavigateMock = MockModularNavigateMock();

    Modular.navigatorDelegate = modularNavigateMock;

    initModule(
      UiAuthModule(),
      replaceBinds: [
        Bind.instance<UserRepository>(userRepositoryMock),
        Bind.instance<CountriesRepository>(countriesRepositoryMock),
        Bind.instance<RouteRepository>(routeRepositoryMock),
      ],
    );

    when(countriesRepositoryMock.readJSON()).thenAnswer(
      (_) async => [
        CountryModel(
          codeCountry: "test1",
          countryName: "test2",
          codeIson: "test3",
          mask: "test4",
        )
      ],
    );

    uiAuthPage = const UiAuthPage();
  });

  testWidgets("when init page show container", (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: uiAuthPage,
    ));
    await widgetTester.pumpAndSettle();

    expect(find.byKey(const Key("uiPageContainer")), findsOneWidget);
  });

  testWidgets("when tap button country", (widgetTester) async {
    when(modularNavigateMock.pushNamed(AppRoute.uICountry)).thenAnswer(
      (_) async => "",
    );

    await widgetTester.pumpWidget(MaterialApp(
      home: uiAuthPage,
    ));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byKey(const Key("uiAuthCountry")));
    await widgetTester.pump();

    verify(Modular.navigatorDelegate?.pushNamed(AppRoute.uICountry)).called(1);
  });

  testWidgets("when selected country", (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: uiAuthPage,
    ));
    await widgetTester.pumpAndSettle();

    expect(
      find.byKey(const Key("uiAuthCountryFailLoadingImageFlag")),
      findsNothing,
    );
  });
}
