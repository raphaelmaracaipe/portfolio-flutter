import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/config/app_route1.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization_impl.dart';
import 'package:portfolio_flutter/modules/uicountry/widget/search_widget.dart';

import './search_widget_test.mocks.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

class BuildContextMock extends Mock implements BuildContext {}

@GenerateMocks([ModularNavigateMock])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MockModularNavigateMock modularNavigateMock = MockModularNavigateMock();
  final navigate = modularNavigateMock;
  Modular.navigatorDelegate = navigate;

  late AppLocalization appLocalization;

  setUp(() {
    appLocalization = AppLocalizationImpl();
    appLocalization.context = BuildContextMock();
  });

  testWidgets(
    "should initialize and build SearchWidget correctly",
    (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SearchWidget(
            countries: const [],
            appLocalization: appLocalization,
          ),
        ),
      ));

      final backgroundColorFinder = find.byWidgetPredicate(
        (widget) => widget is Material && widget.color == AppColors.colorSearch,
      );
      expect(backgroundColorFinder, findsOneWidget);
    },
  );

  testWidgets(
    "when you want tap over item in list",
    (widgetTester) async {
      CountryModel country = CountryModel(
        codeCountry: "55",
        countryName: "brasil",
        codeIson: "BR / BRAA",
        mask: "#####-####",
      );

      when(modularNavigateMock.pushReplacementNamed(
        AppRoute1.uIAuth,
        arguments: country,
      )).thenAnswer(
        (_) async => "",
      );

      List<CountryModel> countries = [
        CountryModel(
          codeCountry: "1",
          countryName: "USA",
          codeIson: "USA",
          mask: "###-#####-####",
        ),
        country,
      ];
      SearchWidget searchWidget = SearchWidget(
        countries: countries,
        appLocalization: appLocalization,
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          home: searchWidget,
        ),
      );
      await widgetTester.pumpAndSettle();

      Finder findSearch = find.byType(TextField);
      await widgetTester.enterText(findSearch, 'brasil');
      await widgetTester.pumpAndSettle();

      Finder finderGesture = find.byKey(const Key("searchUiCountryItem55"));
      expect(finderGesture, findsWidgets);
      await widgetTester.tap(finderGesture);
      await widgetTester.pumpAndSettle();

      verify(Modular.navigatorDelegate?.pushReplacementNamed(
        AppRoute1.uIAuth,
        arguments: country,
      )).called(1);
    },
  );
}
