import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/widgets/bottomsheet/bottom_sheet.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_state.dart';
import 'package:portfolio_flutter/modules/uivalidcode/uivalid_code_pages.dart';

import 'uivalid_code_pages_test.mocks.dart';

class UiValidCodeBlocMock extends Mock implements UiValidCodeBloc {}

class AppLocalizationMock extends Mock implements AppLocalization {}

class BottomSheetMock extends Mock implements Bottomsheet {}

class LoadingMock extends Mock implements Loading {}

class StackRouterMock extends Mock implements StackRouter {}

@GenerateMocks([
  UiValidCodeBlocMock,
  AppLocalizationMock,
  BottomSheetMock,
  LoadingMock,
  StackRouterMock
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockUiValidCodeBlocMock uiValidCodeBlocMock;
  late MockAppLocalizationMock appLocalizationMock;
  late MockBottomSheetMock bottomSheetMock;
  late MockLoadingMock loadingMock;
  late MockStackRouterMock stackRouterMock;

  setUp(() {
    uiValidCodeBlocMock = MockUiValidCodeBlocMock();
    appLocalizationMock = MockAppLocalizationMock();
    bottomSheetMock = MockBottomSheetMock();
    loadingMock = MockLoadingMock();
    stackRouterMock = MockStackRouterMock();

    GetIt.instance.allowReassignment = true;
    GetIt.instance.registerSingleton<UiValidCodeBloc>(uiValidCodeBlocMock);
    GetIt.instance.registerSingleton<AppLocalization>(appLocalizationMock);
    GetIt.instance.registerSingleton<Bottomsheet>(bottomSheetMock);
    GetIt.instance.registerSingleton<Loading>(loadingMock);

    when(appLocalizationMock.localization).thenReturn(null);
  });

  testWidgets(
    'when init view should exit widget',
    (widgetTester) async {
      when(uiValidCodeBlocMock.stream).thenAnswer(
        (_) => const Stream<UiValidCodeBlocUnknown>.empty(),
      );
      when(uiValidCodeBlocMock.state).thenReturn(
        const UiValidCodeBlocUnknown(),
      );

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(const MaterialApp(
          home: UiValidCodePages(),
        ));
        await widgetTester.pumpAndSettle();

        expect(find.byKey(const Key('uiValidCodePage')), findsOneWidget);
      });
    },
  );

  testWidgets(
    'when send code invalid should return message error invalid',
    (widgetTester) async {
      when(stackRouterMock.push(any)).thenAnswer((_) async => {});
      when(uiValidCodeBlocMock.stream).thenAnswer(
        (_) => Stream<UiValidCodeBlocState>.value(
          const UiValidCodeBlocError(
            codeError: HttpErrorEnum.USER_SEND_CODE_INVALID,
          ),
        ),
      );
      when(uiValidCodeBlocMock.state).thenReturn(
        const UiValidCodeBlocError(
          codeError: HttpErrorEnum.USER_SEND_CODE_INVALID,
        ),
      );

      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(MaterialApp(
          home: StackRouterScope(
            controller: stackRouterMock,
            stateHash: 0,
            child: const UiValidCodePages(),
          ),
        ));
        await widgetTester.pumpAndSettle();

        final Finder uiValidCodeTextCode = find.byKey(
          const Key('uiValidCodeTextCode'),
        );
        expect(uiValidCodeTextCode, findsOneWidget);
        await widgetTester.enterText(uiValidCodeTextCode, '123456');
        await widgetTester.pumpAndSettle();

        final Finder uiValidCodeButton = find.byKey(
          const Key('uiValidCodeButton'),
        );
        expect(uiValidCodeButton, findsOneWidget);
        await widgetTester.tap(uiValidCodeButton);
        await widgetTester.pumpAndSettle();
      });
    },
  );

  tearDown(() {
    GetIt.instance.reset();
  });
}
