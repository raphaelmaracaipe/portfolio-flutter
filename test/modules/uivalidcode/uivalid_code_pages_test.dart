import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';
import 'package:portfolio_flutter/config/app_route.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/uivalidcode/uivalid_code_module.dart';
import 'package:portfolio_flutter/modules/uivalidcode/uivalid_code_pages.dart';

import 'uivalid_code_pages_test.mocks.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

class ModularNavigateMock extends Mock implements IModularNavigator {}

@GenerateMocks([
  UserRepositoryMock,
  ModularNavigateMock,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockModularNavigateMock modularNavigateMock;

  setUp(() {
    modularNavigateMock = MockModularNavigateMock();
    Modular.navigatorDelegate = modularNavigateMock;
  });

  testWidgets(
    "when tap code and click over button send",
    (widgetTester) async {
      MockUserRepositoryMock userRepositoryMock = MockUserRepositoryMock();

      when(
        modularNavigateMock.pushNamed(AppRoute.uIProfile),
      ).thenAnswer((_) async => "");

      when(
        userRepositoryMock.requestValidCode(any),
      ).thenAnswer(
        (_) async => ResponseValidCode(
          accessToken: "AAA",
          refreshToken: "BBB",
        ),
      );

      initModule(UiValidCodeModule(), replaceBinds: [
        Bind.instance<UserRepository>(userRepositoryMock),
      ]);

      UiValidCodePages uiValidCodePages = const UiValidCodePages();
      await widgetTester.pumpWidget(MaterialApp(
        home: uiValidCodePages,
      ));
      await widgetTester.pump();
      expect(find.byKey(const Key("uiValidCodePage")), findsOneWidget);

      await widgetTester.enterText(
        find.byKey(
          const Key("uiValidCodeTextCode"),
        ),
        "123456",
      );
      await widgetTester.pump();

      expect(find.byKey(const Key("uiValidCodeButton")), findsOneWidget);
      await widgetTester.tap(find.byKey(const Key("uiValidCodeButton")));
      await widgetTester.pump();

      verifyNever(
        Modular.navigatorDelegate?.pushNamed(AppRoute.uIProfile),
      ).called(0);
    },
  );

  testWidgets(
    "when send code but api return error of code invalid",
    (widgetTester) async {
      MockUserRepositoryMock userRepositoryMock = MockUserRepositoryMock();
      when(
        userRepositoryMock.requestValidCode(any),
      ).thenThrow(HttpException.putEnum(HttpErrorEnum.USER_SEND_CODE_INVALID));

      when(
        modularNavigateMock.pushNamed(AppRoute.uIProfile),
      ).thenAnswer((_) async => "");

      initModule(UiValidCodeModule(), replaceBinds: [
        Bind.instance<UserRepository>(userRepositoryMock),
      ]);

      UiValidCodePages uiValidCodePages = const UiValidCodePages();
      await widgetTester.pumpWidget(MaterialApp(
        home: uiValidCodePages,
      ));
      await widgetTester.pump();
      expect(find.byKey(const Key("uiValidCodePage")), findsOneWidget);

      await widgetTester.enterText(
        find.byKey(
          const Key("uiValidCodeTextCode"),
        ),
        "123456",
      );
      await widgetTester.pump();

      expect(find.byKey(const Key("uiValidCodeButton")), findsOneWidget);
      await widgetTester.tap(find.byKey(const Key("uiValidCodeButton")));
      await widgetTester.pump();
    },
  );

  testWidgets(
    "when send code but api return error of general",
    (widgetTester) async {
      MockUserRepositoryMock userRepositoryMock = MockUserRepositoryMock();
      when(
        userRepositoryMock.requestValidCode(any),
      ).thenThrow(HttpException.putEnum(HttpErrorEnum.ERROR_GENERAL));

      when(
        modularNavigateMock.pushNamed(AppRoute.uIProfile),
      ).thenAnswer((_) async => "");

      initModule(UiValidCodeModule(), replaceBinds: [
        Bind.instance<UserRepository>(userRepositoryMock),
      ]);

      UiValidCodePages uiValidCodePages = const UiValidCodePages();
      await widgetTester.pumpWidget(MaterialApp(
        home: uiValidCodePages,
      ));
      await widgetTester.pump();
      expect(find.byKey(const Key("uiValidCodePage")), findsOneWidget);

      await widgetTester.enterText(
        find.byKey(
          const Key("uiValidCodeTextCode"),
        ),
        "123456",
      );
      await widgetTester.pump();

      expect(find.byKey(const Key("uiValidCodeButton")), findsOneWidget);
      await widgetTester.tap(find.byKey(const Key("uiValidCodeButton")));
      await widgetTester.pump();
    },
  );

  testWidgets(
    'when initializer check if is show',
    (widgetTester) async {
      initModule(UiValidCodeModule());

      UiValidCodePages uiValidCodePages = const UiValidCodePages();
      await widgetTester.pumpWidget(
        MaterialApp(
          home: uiValidCodePages,
        ),
      );
      await widgetTester.pumpAndSettle();
      expect(find.byKey(const Key("uiValidCodePage")), findsOneWidget);
    },
  );
}
