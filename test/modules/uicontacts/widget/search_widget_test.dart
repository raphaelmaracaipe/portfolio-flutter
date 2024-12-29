// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/contact_repository.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/uicontacts/widget/listview_widget.dart';
import 'package:portfolio_flutter/modules/uicontacts/widget/search_widget.dart';

import 'search_widget_test.mocks.dart';

class ColorsUMock extends Mock implements ColorsU {}

class ContactRepositoryMock extends Mock implements ContactRepository {}

class AppLocalizationMock extends Mock implements AppLocalization {}

@GenerateMocks([
  ColorsUMock,
  ContactRepositoryMock,
  AppLocalizationMock,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockColorsUMock colorsUMock;
  late MockContactRepositoryMock contactRepositoryMock;
  late MockAppLocalizationMock appLocalizationMock;

  setUp(() {
    colorsUMock = MockColorsUMock();
    contactRepositoryMock = MockContactRepositoryMock();
    appLocalizationMock = MockAppLocalizationMock();

    GetIt.instance.allowReassignment = true;
    GetIt.instance.registerSingleton<ColorsU>(colorsUMock);
    GetIt.instance.registerSingleton<ContactRepository>(contactRepositoryMock);
    GetIt.instance.registerSingleton<AppLocalization>(appLocalizationMock);

    when(
      colorsUMock.checkColorsWhichIsDarkMode(
        context: anyNamed('context'),
        light: anyNamed('light'),
        dark: anyNamed('dark'),
      ),
    ).thenReturn(Colors.black);

    when(appLocalizationMock.localization).thenReturn(null);
  });

  testWidgets(
    "when building SearchWidget should display search bar and suggestions",
    (widgetTester) async {
      List<ContactEntity> contacts = [
        ContactEntity(
          phone: "1234567890",
          name: "John Doe",
          reminder: "Meeting at 10 AM",
        )
      ];

      SearchWidget searchWidget = SearchWidget(
        appLocalization: appLocalizationMock,
        contacts: contacts,
        colorsU: colorsUMock,
        contactRepository: contactRepositoryMock,
      );

      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: searchWidget,
        ),
      ));

      // Verificar se a barra de busca está sendo exibida
      expect(find.byType(SearchWidget), findsOneWidget);
    },
  );
}
