// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/core/utils/strings.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_state.dart';
import 'package:portfolio_flutter/modules/uiauth/uiauth_pages.dart';

import 'uiauth_pages_test.mocks.dart';

class UiAuthBlocMock extends Mock implements UiAuthBloc {}

class StringsMock extends Mock implements Strings {}

class AppLocalizationMock extends Mock implements AppLocalization {}

class LoadingMock extends Mock implements Loading {}

class StackRouterMock extends Mock implements StackRouter {}

class ColorUMock extends Mock implements ColorsU {}

@GenerateMocks([
  UiAuthBlocMock,
  StringsMock,
  AppLocalizationMock,
  LoadingMock,
  StackRouterMock,
  ColorUMock
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockUiAuthBlocMock uiAuthBlocMock;
  late MockStringsMock stringsMock;
  late MockAppLocalizationMock appLocalizationMock;
  late MockLoadingMock loadingMock;
  late MockStackRouterMock stackRouterMock;
  late MockColorUMock colorUMock;

  setUp(() {
    uiAuthBlocMock = MockUiAuthBlocMock();
    stringsMock = MockStringsMock();
    appLocalizationMock = MockAppLocalizationMock();
    loadingMock = MockLoadingMock();
    stackRouterMock = MockStackRouterMock();
    colorUMock = MockColorUMock();

    GetIt.instance.allowReassignment = true;
    GetIt.instance.registerSingleton<UiAuthBloc>(uiAuthBlocMock);
    GetIt.instance.registerSingleton<Strings>(stringsMock);
    GetIt.instance.registerSingleton<AppLocalization>(appLocalizationMock);
    GetIt.instance.registerSingleton<Loading>(loadingMock);
    GetIt.instance.registerSingleton<ColorsU>(colorUMock);

    when(appLocalizationMock.localization).thenReturn(null);
    when(stringsMock.onlyNumber(any)).thenReturn('999');
    when(
      colorUMock.checkColorsWhichIsDarkMode(
        context: anyNamed('context'),
        light: anyNamed('light'),
        dark: anyNamed('dark'),
      ),
    ).thenReturn(Colors.black);
  });

  testWidgets(
    'when tap in item to seen list of countries',
    (widgetTester) async {
      when(uiAuthBlocMock.stream).thenAnswer(
        (_) => const Stream<UiAuthBlocState>.empty(),
      );
      when(uiAuthBlocMock.state).thenReturn(UiAuthBlocUnknown());
      when(stackRouterMock.push(any)).thenAnswer((_) async => {});

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(MaterialApp(
          home: StackRouterScope(
            controller: stackRouterMock,
            stateHash: 0,
            child: const UiAuthPage(),
          ),
        ));
        await widgetTester.pumpAndSettle();

        expect(find.byKey(const Key('uiPageContainer')), findsOneWidget);

        final Finder uiAuthCountry = find.byKey(const Key('uiAuthCountry'));
        expect(uiAuthCountry, findsWidgets);
        await widgetTester.tap(uiAuthCountry);

        verify(stackRouterMock.push(any)).called(1);
      });
    },
  );

  testWidgets(
    'when init view should exit widget',
    (widgetTester) async {
      when(uiAuthBlocMock.stream).thenAnswer(
        (_) => const Stream<UiAuthBlocState>.empty(),
      );
      when(uiAuthBlocMock.state).thenReturn(UiAuthBlocUnknown());

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(const MaterialApp(
          home: UiAuthPage(),
        ));
        await widgetTester.pumpAndSettle();

        expect(find.byKey(const Key('uiPageContainer')), findsOneWidget);
      });
    },
  );

  testWidgets(
    'when call state of loading should return widget with loading',
    (widgetTester) async {
      when(uiAuthBlocMock.stream).thenAnswer(
        (_) => Stream<UiAuthBlocState>.value(UiAuthBlocLoading()),
      );
      when(uiAuthBlocMock.state).thenReturn(UiAuthBlocLoading());
      when(loadingMock.showLoading(any, any)).thenAnswer((_) => const Text(
            "test",
            key: Key('testWidget'),
          ));

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(const MaterialApp(
          home: UiAuthPage(),
        ));
        await widgetTester.pumpAndSettle();

        expect(find.byKey(const Key('testWidget')), findsWidgets);
      });
    },
  );

  testWidgets(
    'when entry with text to code country should found and put name country in field',
    (widgetTester) async {
      final List<CountryModel> listOfCountries = [
        CountryModel(
          codeCountry: '55',
          countryName: 'Brasil',
          codeIson: 'BR / BRA',
          mask: '##-#####-####',
        )
      ];

      when(uiAuthBlocMock.stream).thenAnswer(
        (_) => Stream<UiAuthBlocState>.value(UiAuthBlocLoaded(listOfCountries)),
      );
      when(uiAuthBlocMock.state).thenReturn(UiAuthBlocLoaded(listOfCountries));
      when(loadingMock.showLoading(any, any)).thenAnswer((_) => const Text(
            "test",
            key: Key('testWidget'),
          ));

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(const MaterialApp(
          home: UiAuthPage(),
        ));
        await widgetTester.pumpAndSettle();

        expect(find.byKey(const Key('uiPageContainer')), findsWidgets);

        final Finder uiAuthFieldCountryCode = find.byKey(
          const Key('uiAuthFieldCountryCode'),
        );
        expect(uiAuthFieldCountryCode, findsWidgets);
        await widgetTester.enterText(uiAuthFieldCountryCode, '55');
        await widgetTester.pumpAndSettle();

        expect(find.text('Brasil'), findsWidgets);
      });
    },
  );

  tearDown(() {
    GetIt.instance.reset();
  });
}
