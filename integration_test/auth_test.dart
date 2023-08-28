import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';
import 'package:portfolio_flutter/app.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/core/data/hand_shake_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/uiauth/uiauth_module.dart';
import 'package:portfolio_flutter/modules/uicountry/uicountry_module.dart';
import 'package:portfolio_flutter/modules/uisplash/uisplash_module.dart';
import 'package:portfolio_flutter/modules/uivalidcode/uivalid_code_module.dart';

import '../test/modules/uiauth/bloc/uiauth_bloc_test.mocks.dart';
import '../test/modules/uisplash/bloc/uisplash_bloc_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockHandShakeRepositoryMock handShakeRepositoryMock;
  late MockCountriesRepositoryMock countriesRepositoryMock;
  late MockUserRepositoryMock userRepositoryMock;

  setUp(() {
    handShakeRepositoryMock = MockHandShakeRepositoryMock();
    countriesRepositoryMock = MockCountriesRepositoryMock();
    userRepositoryMock = MockUserRepositoryMock();
  });

  testWidgets(
    'Navigation of auth in the app.',
    (widgetTester) async {
      when(handShakeRepositoryMock.send()).thenAnswer((_) async {});
      when(userRepositoryMock.requestCode(any)).thenAnswer((_) async {});
      when(userRepositoryMock.requestValidCode(any)).thenAnswer(
        (_) async => ResponseValidCode(
            accessToken: "access token", refreshToken: "refresh token"),
      );
      when(countriesRepositoryMock.readJSON()).thenAnswer(
        (_) async => [
          CountryModel(
            codeCountry: '55',
            codeIson: 'BR / BRA',
            countryName: 'Brasil',
            mask: '##-####-####',
          ),
        ],
      );

      initModules([
        UiSplashModule(),
        UiCountryModule(),
        UiAuthModule()
      ], replaceBinds: [
        Bind.instance<HandShakeRepository>(handShakeRepositoryMock),
        Bind.instance<UserRepository>(userRepositoryMock),
        Bind.instance<CountriesRepository>(countriesRepositoryMock),
      ]);

      await widgetTester.pumpWidget(
        ModularApp(module: AppModule(), child: const AppWidget()),
      );
      await widgetTester.pump(const Duration(seconds: 5));

      // Checking of splash
      final Finder findContainer = find.byKey(const Key('uisplash_container'));
      expect(findContainer, findsOneWidget);
      await widgetTester.pumpAndSettle();

      // Checking of uiauth
      initModules([
        UiCountryModule(),
        UiAuthModule()
      ], replaceBinds: [
        Bind.instance<UserRepository>(userRepositoryMock),
        Bind.instance<CountriesRepository>(countriesRepositoryMock),
      ]);

      // Checking of country
      final Finder uiAuthCountry = find.byKey(const Key('uiAuthCountry'));
      expect(uiAuthCountry, findsOneWidget);
      await widgetTester.tap(uiAuthCountry);
      await widgetTester.pumpAndSettle();

      // enter text of country search
      final Finder searchField = find.byType(TextField);
      await widgetTester.enterText(searchField, 'brasil');
      await widgetTester.pumpAndSettle();

      // Tap item found
      final Finder searchResult = find.byKey(
        const Key('searchUiCountryItem55'),
      );
      expect(searchResult, findsOneWidget);
      await widgetTester.tap(searchResult);
      await widgetTester.pumpAndSettle();

      // Check if item found arrived in uiauthpage
      final Finder countryBrazil = find.text('Brasil');
      expect(countryBrazil, findsOneWidget);

      // Enter text with code of country
      final Finder uiAuthFieldCountryCode = find.byKey(
        const Key('uiAuthFieldCountryCode'),
      );
      expect(uiAuthFieldCountryCode, findsOneWidget);
      await widgetTester.enterText(uiAuthFieldCountryCode, '55');
      await widgetTester.pumpAndSettle();

      // Enter text with phone number
      final Finder uiAuthFieldPhone = find.byKey(
        const Key('uiAuthFieldPhone'),
      );
      expect(uiAuthFieldPhone, findsOneWidget);
      await widgetTester.enterText(uiAuthFieldPhone, '619182993098');
      await widgetTester.pumpAndSettle();

      // Tap button to send
      final Finder uiAuthButtonSend = find.byKey(const Key('uiAuthButtonSend'));
      expect(uiAuthButtonSend, findsOneWidget);
      await widgetTester.tap(uiAuthButtonSend);

      // Check if is show screen validated code
      initModules([
        UiValidCodeModule(),
      ], replaceBinds: [
        Bind.instance<UserRepository>(userRepositoryMock),
      ]);
      await widgetTester.pumpAndSettle();

      final Finder uiValidCodePage = find.byKey(const Key('uiValidCodePage'));
      expect(uiValidCodePage, findsOneWidget);

      // Enter text with code of validation
      final Finder uiValidCodeTextCode = find.byKey(
        const Key('uiValidCodeTextCode'),
      );
      await widgetTester.enterText(uiValidCodeTextCode, '123456');
      await widgetTester.pumpAndSettle();

      // Tap button of valid code
      final Finder uiValidCodeButton = find.byKey(
        const Key('uiValidCodeButton'),
      );
      expect(uiValidCodeButton, findsOneWidget);
      await widgetTester.tap(uiValidCodeButton);
      await widgetTester.pumpAndSettle();

      // Check if is show screen uiprofile
      final Finder uiProfileContainer = find.byKey(
        const Key('uiProfileContainer'),
      );
      expect(uiProfileContainer, findsOneWidget);
    },
  );

  tearDown(() {
    cleanModular();
  });
}