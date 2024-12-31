import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/contact_repository.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/uicontacts/bloc/uicontact_bloc.dart';
import 'package:portfolio_flutter/modules/uicontacts/bloc/uicontact_bloc_state.dart';
import 'package:portfolio_flutter/modules/uicontacts/uicontact_pages.dart';
import 'package:portfolio_flutter/modules/uicontacts/widget/listview_widget.dart';
import 'package:portfolio_flutter/modules/uicontacts/widget/search_widget.dart';

import 'uicontact_pages_test.mocks.dart';

class StackRouterMock extends Mock implements StackRouter {}

class ColorUMock extends Mock implements ColorsU {}

class AppLocalizationMock extends Mock implements AppLocalization {}

class ContactRepositoryMock extends Mock implements ContactRepository {}

class UiContactBlocMock extends Mock implements UiContactBloc {}

@GenerateMocks([
  StackRouterMock,
  ColorUMock,
  AppLocalizationMock,
  UiContactBlocMock,
  ContactRepositoryMock,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockStackRouterMock stackRouterMock;
  late MockColorUMock colorUMock;
  late MockAppLocalizationMock appLocalizationMock;
  late MockUiContactBlocMock uiContactBlocMock;
  late MockContactRepositoryMock contactRepositoryMock;

  setUp(() {
    stackRouterMock = MockStackRouterMock();
    colorUMock = MockColorUMock();
    appLocalizationMock = MockAppLocalizationMock();
    uiContactBlocMock = MockUiContactBlocMock();
    contactRepositoryMock = MockContactRepositoryMock();

    GetIt.instance.allowReassignment = true;
    GetIt.instance.registerSingleton<ColorsU>(colorUMock);
    GetIt.instance.registerSingleton<AppLocalization>(appLocalizationMock);
    GetIt.instance.registerSingleton<UiContactBloc>(uiContactBlocMock);
    GetIt.instance.registerSingleton<ContactRepository>(contactRepositoryMock);
    GetIt.instance.registerSingleton<StackRouter>(stackRouterMock);

    when(appLocalizationMock.localization).thenReturn(null);
    when(
      colorUMock.checkColorsWhichIsDarkMode(
        context: anyNamed('context'),
        light: anyNamed('light'),
        dark: anyNamed('dark'),
      ),
    ).thenReturn(Colors.black);
  });

  testWidgets(
    'UiContactPages displays search and list view',
    (WidgetTester tester) async {
      when(uiContactBlocMock.stream).thenAnswer(
        (_) => const Stream<UiContactBlocState>.empty(),
      );
      when(uiContactBlocMock.state).thenReturn(
        UiContactBlocUnknown(),
      );

      await tester.pumpWidget(const MaterialApp(
        home: UiContactPages(),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(SearchWidget), findsOneWidget);
      expect(find.byType(ListViewWidget), findsOneWidget);
    },
  );

  testWidgets(
    'when permission not granted, UiContactPages displays snackbar',
    (WidgetTester tester) async {
      when(uiContactBlocMock.stream).thenAnswer(
        (_) => const Stream<UiContactBlocPermissionNotGranted>.empty(),
      );
      when(uiContactBlocMock.state).thenReturn(
        UiContactBlocPermissionNotGranted(),
      );

      await tester.pumpWidget(const MaterialApp(
        home: UiContactPages(),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
    },
  );
}
