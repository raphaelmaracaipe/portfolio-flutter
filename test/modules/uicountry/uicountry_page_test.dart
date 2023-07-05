import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/uicountry/uicountry_module.dart';
import 'package:portfolio_flutter/modules/uicountry/uicountry_page.dart';

import 'uicountry_page_test.mocks.dart';

class CountriesRepositoryMock extends Mock implements CountriesRepository {}

@GenerateMocks([CountriesRepositoryMock])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("UiCountryPage", () {
    testWidgets(
      "when initializer check if show",
      (widgetTester) async {
        initModule(UiCountryModule());

        UiCountryPage uiCountryPage = const UiCountryPage();
        await widgetTester.pumpWidget(MaterialApp(
          home: uiCountryPage,
        ));
        await widgetTester.pump();

        expect(
          find.byKey(const Key("uiCountryContainer")),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      "when list countries should show items",
      (widgetTester) async {
        List<CountryModel> countries = [
          CountryModel(
            codeCountry: "AAA",
            countryName: "BBB",
            codeIson: "CCC",
            mask: "DDD",
          )
        ];

        MockCountriesRepositoryMock countriesRepository = MockCountriesRepositoryMock();
        when(countriesRepository.readJSON()).thenAnswer(
          (_) async => countries,
        );

        initModule(UiCountryModule(), replaceBinds: [
          Bind.instance<CountriesRepository>(countriesRepository)
        ]);

        UiCountryPage uiCountryPage = const UiCountryPage();
        await widgetTester.pumpWidget(MaterialApp(
          home: uiCountryPage,
        ));
        await widgetTester.pump();

        expect(
          find.byKey(const Key("listViewUiCountryContainer")),
          findsWidgets,
        );
      },
    );

    testWidgets(
      "when receiver list of countries but list is empty do not should shou list of itens",
      (widgetTester) async {
        MockCountriesRepositoryMock countriesRepositoryMock =
            MockCountriesRepositoryMock();
        when(countriesRepositoryMock.readJSON()).thenAnswer((_) async => []);

        initModule(UiCountryModule(), replaceBinds: [
          Bind.instance<CountriesRepository>(countriesRepositoryMock)
        ]);

        UiCountryPage uiCountryPage = const UiCountryPage();
        await widgetTester.pumpWidget(MaterialApp(
          home: uiCountryPage,
        ));

        expect(
          find.byKey(const Key("listViewUiCountryContainer")),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key("listViewUiCountryItem")),
          findsNothing,
        );
      },
    );

    testWidgets(
      "when receiver list of countries but happens error not should shou list of itens",
      (widgetTester) async {
        MockCountriesRepositoryMock countriesRepositoryMock =
            MockCountriesRepositoryMock();
        when(countriesRepositoryMock.readJSON())
            .thenThrow(Exception("error test"));

        initModule(UiCountryModule(), replaceBinds: [
          Bind.instance<CountriesRepository>(countriesRepositoryMock)
        ]);

        UiCountryPage uiCountryPage = const UiCountryPage();
        await widgetTester.pumpWidget(MaterialApp(
          home: uiCountryPage,
        ));

        expect(
          find.byKey(const Key("listViewUiCountryContainer")),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key("listViewUiCountryItem")),
          findsNothing,
        );
      },
    );
  });
}
