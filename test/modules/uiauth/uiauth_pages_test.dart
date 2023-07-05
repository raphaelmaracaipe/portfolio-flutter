import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';
import 'package:portfolio_flutter/modules/app_router.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/uiauth/uiauth_module.dart';
import 'package:portfolio_flutter/modules/uiauth/uiauth_pages.dart';

import 'uiauth_pages_test.mocks.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

@GenerateMocks([ModularNavigateMock])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MockModularNavigateMock modularNavigateMock = MockModularNavigateMock();
  final navigate = modularNavigateMock;
  Modular.navigatorDelegate = navigate;

  setUp(() {
    initModule(UiAuthModule());
  });

  group("UiAuthPage", () {
    testWidgets("when init page show container", (widgetTester) async {
      UiAuthPage uiAuthPage = UiAuthPage();
      await widgetTester.pumpWidget(MaterialApp(
        home: uiAuthPage,
      ));

      expect(find.byKey(const Key("uiPageContainer")), findsOneWidget);
    });

    testWidgets("when tap button country", (widgetTester) async {
      when(modularNavigateMock.pushNamed(AppRouter.uICountry)).thenAnswer(
        (_) async => "",
      );

      UiAuthPage uiAuthPage = UiAuthPage();
      await widgetTester.pumpWidget(MaterialApp(
        home: uiAuthPage,
      ));

      await widgetTester.tap(find.byKey(const Key("uiAuthCountry")));
      await widgetTester.pump();

      verify(Modular.navigatorDelegate?.pushNamed(AppRouter.uICountry)).called(1);
    });

    testWidgets("when selected country", (widgetTester) async {
      UiAuthPage uiAuthPage = UiAuthPage();
      uiAuthPage.countrySelected = CountryModel(
        codeCountry: "Afghanistan",
        countryName: "93",
        codeIson: "AF / AFG",
        mask: "##-###-####",
      );

      await widgetTester.pumpWidget(MaterialApp(
        home: uiAuthPage,
      ));

      expect(
        find.byKey(const Key("uiAuthCountryFailLoadingImageFlag")),
        findsNothing,
      );
    });
  });
}
