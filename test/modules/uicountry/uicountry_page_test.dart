import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_state.dart';
import 'package:portfolio_flutter/modules/uicountry/uicountry_page.dart';

import 'uicountry_page_test.mocks.dart';

class UICountryBlocMock extends Mock implements UICountryBloc {}

class AppLocalizationMock extends Mock implements AppLocalization {}

class LoadingMock extends Mock implements Loading {}

class StackRouterMock extends Mock implements StackRouter {}

@GenerateMocks([
  UICountryBlocMock,
  AppLocalizationMock,
  LoadingMock,
  StackRouterMock,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockUICountryBlocMock uiCountryBlocMock;
  late MockAppLocalizationMock appLocalizationMock;
  late MockLoadingMock loadingMock;
  late MockStackRouterMock stackRouterMock;

  setUp(() {
    uiCountryBlocMock = MockUICountryBlocMock();
    appLocalizationMock = MockAppLocalizationMock();
    loadingMock = MockLoadingMock();
    stackRouterMock = MockStackRouterMock();

    GetIt.instance.allowReassignment = true;
    GetIt.instance.registerSingleton<UICountryBloc>(uiCountryBlocMock);
    GetIt.instance.registerSingleton<AppLocalization>(appLocalizationMock);
    GetIt.instance.registerSingleton<Loading>(loadingMock);

    when(appLocalizationMock.localization).thenReturn(null);
  });

  testWidgets(
    'when init view should exit widget',
    (widgetTester) async {
      when(uiCountryBlocMock.stream).thenAnswer(
        (_) => const Stream<UiCountryBlocUnknown>.empty(),
      );
      when(uiCountryBlocMock.state).thenReturn(UiCountryBlocUnknown());

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(MaterialApp(
          home: UiCountryPage(),
        ));
        await widgetTester.pumpAndSettle();

        expect(find.byKey(const Key('uiCountryContainer')), findsOneWidget);
      });
    },
  );

  testWidgets(
    'when send event loading should show view',
    (widgetTester) async {
      when(uiCountryBlocMock.stream).thenAnswer(
        (_) => const Stream<UiCountryBlocLoading>.empty(),
      );
      when(uiCountryBlocMock.state).thenReturn(UiCountryBlocLoading());
      when(loadingMock.showLoading(any)).thenReturn(const Text(
        'test',
        key: Key('testview'),
      ));

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(MaterialApp(
          home: UiCountryPage(),
        ));
        await widgetTester.pumpAndSettle();

        expect(find.byKey(const Key('testview')), findsOneWidget);
      });
    },
  );

  testWidgets(
    'a',
    (widgetTester) async {
      final List<CountryModel> countries = [
        CountryModel(
          codeCountry: '99',
          countryName: 'Brasil',
          codeIson: 'BR / BRA',
          mask: '##-#####-####',
        )
      ];

      when(uiCountryBlocMock.stream).thenAnswer(
        (_) => Stream<UiCountryBlocLoaded>.value(
          UiCountryBlocLoaded(countries),
        ),
      );
      when(uiCountryBlocMock.state).thenReturn(UiCountryBlocLoaded(countries));
      when(loadingMock.showLoading(any)).thenReturn(const Text(
        'test',
        key: Key('testview'),
      ));

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(MaterialApp(
          home: StackRouterScope(
            controller: stackRouterMock,
            stateHash: 0,
            child: UiCountryPage(),
          ),
        ));
        await widgetTester.pumpAndSettle();

        final Finder listViewUiCountryItem99 = find.byKey(
          const Key('listViewUiCountryItem99'),
        );
        expect(
          listViewUiCountryItem99,
          findsWidgets,
        );
        await widgetTester.tap(listViewUiCountryItem99);
        await widgetTester.pumpAndSettle();
      });
    },
  );

  tearDown(() {
    GetIt.instance.reset();
  });
}
