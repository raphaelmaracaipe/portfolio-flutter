import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/core/utils/files.dart';
import 'package:portfolio_flutter/modules/core/widgets/bottomsheet/bottom_sheet.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc_state.dart';
import 'package:portfolio_flutter/modules/uiprofile/uiprofile_page.dart';

import 'uiprofile_page_test.mocks.dart';

class UiProfileBlocMock extends Mock implements UiProfileBloc {}

class AppLocalizationMock extends Mock implements AppLocalization {}

class LoadingMock extends Mock implements Loading {}

class StackRouterMock extends Mock implements StackRouter {}

class FileMock extends Mock implements Files {}

class BottomsheetMock extends Mock implements Bottomsheet {}

class ColorUMock extends Mock implements ColorsU {}

@GenerateMocks([
  UiProfileBlocMock,
  AppLocalizationMock,
  LoadingMock,
  StackRouterMock,
  FileMock,
  BottomsheetMock,
  ColorUMock
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockUiProfileBlocMock uiProfileBlocMock;
  late MockAppLocalizationMock appLocalizationMock;
  late MockLoadingMock loadingMock;
  late MockStackRouterMock stackRouterMock;
  late MockFileMock fileMock;
  late MockBottomsheetMock bottomsheetMock;
  late MockColorUMock colorUMock;

  setUp(() {
    uiProfileBlocMock = MockUiProfileBlocMock();
    appLocalizationMock = MockAppLocalizationMock();
    loadingMock = MockLoadingMock();
    stackRouterMock = MockStackRouterMock();
    fileMock = MockFileMock();
    bottomsheetMock = MockBottomsheetMock();
    colorUMock = MockColorUMock();

    GetIt.instance.allowReassignment = true;
    GetIt.instance.registerSingleton<UiProfileBloc>(uiProfileBlocMock);
    GetIt.instance.registerSingleton<AppLocalization>(appLocalizationMock);
    GetIt.instance.registerSingleton<Loading>(loadingMock);
    GetIt.instance.registerSingleton<StackRouter>(stackRouterMock);
    GetIt.instance.registerSingleton<Files>(fileMock);
    GetIt.instance.registerSingleton<Bottomsheet>(bottomsheetMock);
    GetIt.instance.registerSingleton<ColorsU>(colorUMock);

    when(appLocalizationMock.localization).thenReturn(null);
    when(
      colorUMock.checkColorsWhichIsDarkMode(
        context: anyNamed('context'),
        light: anyNamed('light'),
        dark: anyNamed('dark'),
      ),
    ).thenReturn(Colors.black);
  });

  testWidgets('when init view', (widgetTester) async {
    when(uiProfileBlocMock.stream).thenAnswer(
      (_) => const Stream<UiProfileBlocState>.empty(),
    );
    when(uiProfileBlocMock.state).thenReturn(
      const UiProfileBlocStateUknown(),
    );

    await widgetTester.pumpWidget(const MaterialApp(
      home: UiProfilePage(),
    ));
    await widgetTester.pumpAndSettle();

    final Finder uiProfileContainer = find.byKey(
      const Key('uiProfileContainer'),
    );
    await widgetTester.pumpAndSettle();

    expect(uiProfileContainer, findsOneWidget);
  });

  testWidgets(
    'when bloc return success should redirect to contacts',
    (widgetTester) async {
      when(uiProfileBlocMock.stream).thenAnswer(
        (_) => const Stream<UiProfileBlocState>.empty(),
      );
      when(uiProfileBlocMock.state).thenReturn(
        const UiProfileBlocStateUpdateSuccess(),
      );
      when(stackRouterMock.popAndPush(any)).thenAnswer((_) async => {});

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(MaterialApp(
          home: StackRouterScope(
            controller: stackRouterMock,
            stateHash: 0,
            child: const UiProfilePage(),
          ),
        ));
        await widgetTester.pumpAndSettle();

        verify(stackRouterMock.popAndPush(any)).called(1);
      });
    },
  );

  testWidgets(
    'when bloc return loading should show loading',
    (widgetTester) async {
      when(uiProfileBlocMock.stream).thenAnswer(
        (_) => const Stream<UiProfileBlocState>.empty(),
      );
      when(uiProfileBlocMock.state).thenReturn(
        const UiProfileBlocStateLoading(),
      );
      when(loadingMock.showLoading(any, any)).thenAnswer((_) => Container());

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(MaterialApp(
          home: StackRouterScope(
            controller: stackRouterMock,
            stateHash: 0,
            child: const UiProfilePage(),
          ),
        ));
        await widgetTester.pumpAndSettle();

        verify(loadingMock.showLoading(any, any)).called(1);
      });
    },
  );

  testWidgets(
    'when bloc return error show message error',
    (widgetTester) async {
      when(uiProfileBlocMock.stream).thenAnswer(
        (_) => const Stream<UiProfileBlocState>.empty(),
      );
      when(uiProfileBlocMock.state).thenReturn(
        const UiProfileBlocStateError(),
      );

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(MaterialApp(
          home: StackRouterScope(
            controller: stackRouterMock,
            stateHash: 0,
            child: const UiProfilePage(),
          ),
        ));
        await widgetTester.pumpAndSettle();

        final Finder uiProfilePageMessageError = find.byKey(
          const Key('UiProfilePageMessageError'),
        );
        await widgetTester.pumpAndSettle();
        expect(uiProfilePageMessageError, findsOneWidget);
      });
    },
  );

  testWidgets(
    'when click in button to continue but not send data name and profile should show bottom sheet of alert',
    (widgetTester) async {
      when(uiProfileBlocMock.stream).thenAnswer(
        (_) => const Stream<UiProfileBlocState>.empty(),
      );
      when(uiProfileBlocMock.state).thenReturn(
        const UiProfileBlocStateUknown(),
      );
      when(bottomsheetMock.show(
        context: anyNamed("context"),
        title: anyNamed("title"),
        btnText: anyNamed("btnText"),
      )).thenAnswer((_) async {});

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(MaterialApp(
          home: StackRouterScope(
            controller: stackRouterMock,
            stateHash: 0,
            child: const UiProfilePage(),
          ),
        ));
        await widgetTester.pumpAndSettle();

        final Finder uiProfilePageButtonContinue = find.byKey(
          const Key('UiProfilePageButtonContinue'),
        );
        await widgetTester.pumpAndSettle();
        expect(uiProfilePageButtonContinue, findsOneWidget);
        await widgetTester.tap(uiProfilePageButtonContinue);
      });
    },
  );
}
