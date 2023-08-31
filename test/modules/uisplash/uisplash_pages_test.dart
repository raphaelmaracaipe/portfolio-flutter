// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:modular_test/modular_test.dart';
// import 'package:portfolio_flutter/modules/uisplash/uisplash_page.dart';
//
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//
//   testWidgets('when init check if is show container', (widgetTester) async {
//     UiSplashPage page = const UiSplashPage();
//     await widgetTester.pumpWidget(MaterialApp(
//       home: page,
//     ));
//     await widgetTester.pump(const Duration(seconds: 5));
//
//     Finder findContainer = find.byKey(const Key('uisplash_container'));
//     expect(findContainer, findsOneWidget);
//   });
// }

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/widgets/bottomsheet/bottom_sheet.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_state.dart';
import 'package:portfolio_flutter/modules/uisplash/uisplash_page.dart';

import 'uisplash_pages_test.mocks.dart';

class UiSplashBlocMock extends Mock implements UiSplashBloc {}

class UiBottomSheetMock extends Mock implements Bottomsheet {}

class AppLocalizationMock extends Mock implements AppLocalization {}

class StackRouterMock extends Mock implements StackRouter {}

@GenerateMocks([
  UiSplashBlocMock,
  UiBottomSheetMock,
  AppLocalizationMock,
  StackRouterMock,
])
void main() {
  late MockUiSplashBlocMock uiSplashBlocMock;
  late MockUiBottomSheetMock uiBottomSheetMock;
  late MockAppLocalizationMock appLocalizationMock;
  late MockStackRouterMock stackRouterMock;

  setUp(() {
    uiSplashBlocMock = MockUiSplashBlocMock();
    uiBottomSheetMock = MockUiBottomSheetMock();
    appLocalizationMock = MockAppLocalizationMock();
    stackRouterMock = MockStackRouterMock();

    GetIt.instance.allowReassignment = true;
    GetIt.instance.registerSingleton<UiSplashBloc>(uiSplashBlocMock);
    GetIt.instance.registerSingleton<Bottomsheet>(uiBottomSheetMock);
    GetIt.instance.registerSingleton<AppLocalization>(appLocalizationMock);
  });

  testWidgets(
    'when init view should return unknown in block',
    (widgetTester) async {
      when(uiSplashBlocMock.stream).thenAnswer(
        (_) => const Stream<UiSplashBlocState>.empty(),
      ); // Stub the stream
      when(uiSplashBlocMock.state).thenReturn(const UiSplashBlocUnknown());

      await widgetTester.pumpWidget(const MaterialApp(
        home: UiSplashPage(),
      ));
      await widgetTester.pump();

      expect(find.byKey(const Key('uisplash_container')), findsWidgets);
    },
  );

  testWidgets(
    'when init view and return router saved',
    (widgetTester) async {
      const String routeName = 'test of route';
      when(uiSplashBlocMock.stream).thenAnswer(
        (_) => Stream<UiSplashBlocState>.value(
          const UiSplashBlocRoute(routeName: routeName),
        ),
      );
      when(uiSplashBlocMock.state).thenReturn(
        const UiSplashBlocRoute(routeName: routeName),
      );
      when(stackRouterMock.push(any)).thenAnswer((_) async => {});

      await widgetTester.pumpWidget(MaterialApp(
        home: StackRouterScope(
          controller: stackRouterMock,
          stateHash: 0,
          child: const UiSplashPage(),
        ),
      ));
      await widgetTester.pump();

      expect(find.byKey(const Key('uisplash_container')), findsWidgets);
      verify(stackRouterMock.push(any)).called(2);
    },
  );

  testWidgets(
    'when finished register of hand shake should return event to view',
    (widgetTester) async {
      when(uiSplashBlocMock.stream).thenAnswer(
        (_) => Stream<UiSplashBlocState>.value(
          const UiSplashBlocFinishHandShake(),
        ),
      );
      when(uiSplashBlocMock.state).thenReturn(
        const UiSplashBlocFinishHandShake(),
      );

      when(stackRouterMock.push(any)).thenAnswer((_) async => {});

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(MaterialApp(
          home: StackRouterScope(
            controller: stackRouterMock,
            stateHash: 0,
            child: const UiSplashPage(),
          ),
        ));
        await widgetTester.pump();

        expect(find.byKey(const Key('container_empty')), findsWidgets);
      });
    },
  );

  testWidgets(
    'when try register in api but return error should send event to view with error',
    (widgetTester) async {
      when(uiSplashBlocMock.stream).thenAnswer(
        (_) => Stream<UiSplashBlocState>.value(
          const UiSplashBlocHandShakeError(),
        ),
      );
      when(uiSplashBlocMock.state).thenReturn(
        const UiSplashBlocHandShakeError(),
      );

      when(stackRouterMock.push(any)).thenAnswer((_) async => {});

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(MaterialApp(
          home: StackRouterScope(
            controller: stackRouterMock,
            stateHash: 0,
            child: const UiSplashPage(),
          ),
        ));
        await widgetTester.pump();

        expect(find.byKey(const Key('container_empty')), findsWidgets);
      });
    },
  );

  tearDown(() {
    GetIt.instance.reset();
  });
}
