import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';
import 'package:portfolio_flutter/main_dev.dart' as app;
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/uiauth/uiauth_module.dart';
import 'package:portfolio_flutter/modules/uicountry/uicountry_module.dart';
import 'package:portfolio_flutter/modules/uivalidcode/uivalid_code_module.dart';

import '../test/modules/uiauth/uiauth_pages_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
    "when tap in countries should show code, flag and name in fields",
    (tester) async {
      initModules(
        [
          UiAuthModule(),
          UiCountryModule(),
          UiValidCodeModule(),
        ],
      );

      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("uiAuthCountry")));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Afghanistan"));
      await tester.pumpAndSettle();

      expect(find.text("93"), findsOneWidget);
    },
  );

  testWidgets(
    "when select country and text mask",
    (tester) async {
      initModules(
        [
          UiAuthModule(),
          UiCountryModule(),
          UiValidCodeModule(),
        ],
      );

      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("uiAuthCountry")));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Afghanistan"));
      await tester.pumpAndSettle();
      expect(find.text("93"), findsOneWidget);

      await tester.enterText(
        find.byKey(const Key("uiAuthFieldPhone")),
        '999999999',
      );
      await tester.pumpAndSettle();

      var testController = find
          .byKey(const Key("uiAuthFieldPhone"))
          .evaluate()
          .single
          .widget as TextField;

      String text = testController.controller?.text ?? "";
      expect(text, '99-999-9999');
    },
  );

  testWidgets(
    'when request code and api return success should redirect to page of code',
    (tester) async {
      MockUserRepositoryMock userRepositoryMock = MockUserRepositoryMock();
      when(userRepositoryMock.requestCode(any)).thenAnswer((_) async => true);

      initModules(
        [
          UiAuthModule(),
          UiCountryModule(),
          UiValidCodeModule(),
        ],
        replaceBinds: [
          Bind.instance<UserRepository>(userRepositoryMock),
        ],
      );

      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("uiAuthCountry")));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Afghanistan"));
      await tester.pumpAndSettle();
      expect(find.text("93"), findsOneWidget);

      await tester.enterText(
        find.byKey(const Key("uiAuthFieldPhone")),
        '999999999',
      );
      await tester.pump();

      var testController = find
          .byKey(const Key("uiAuthFieldPhone"))
          .evaluate()
          .single
          .widget as TextField;

      String text = testController.controller?.text ?? "";
      expect(text, '99-999-9999');

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      Finder finderButton = find.byKey(const Key("uiAuthButtonSend"));
      expect(finderButton, findsOneWidget);
      await tester.tap(finderButton);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key("uiValidCodePage")), findsOneWidget);
    },
  );

  testWidgets(
    'when request code and api return error should show message error',
    (tester) async {
      MockUserRepositoryMock userRepositoryMock = MockUserRepositoryMock();
      when(
        userRepositoryMock.requestCode(any),
      ).thenThrow(HttpException.putEnum(HttpErrorEnum.ERROR_GENERAL));

      initModules(
        [
          UiAuthModule(),
          UiCountryModule(),
          UiValidCodeModule(),
        ],
        replaceBinds: [
          Bind.instance<UserRepository>(userRepositoryMock),
        ],
      );

      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("uiAuthCountry")));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Afghanistan"));
      await tester.pumpAndSettle();
      expect(find.text("93"), findsOneWidget);

      await tester.enterText(
        find.byKey(const Key("uiAuthFieldPhone")),
        '999999999',
      );
      await tester.pump();

      var testController = find
          .byKey(const Key("uiAuthFieldPhone"))
          .evaluate()
          .single
          .widget as TextField;

      String text = testController.controller?.text ?? "";
      expect(text, '99-999-9999');

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      Finder finderButton = find.byKey(const Key("uiAuthButtonSend"));
      expect(finderButton, findsOneWidget);
      await tester.tap(finderButton);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key("uiPageContainer")), findsOneWidget);
    },
  );

  testWidgets(
    'when request to valid code success should redirect to profile',
    (tester) async {
      MockUserRepositoryMock userRepositoryMock = MockUserRepositoryMock();
      when(
        userRepositoryMock.requestCode(any),
      ).thenAnswer((_) async => true);
      when(
        userRepositoryMock.requestValidCode(any),
      ).thenAnswer(
        (_) async => ResponseValidCode(
          accessToken: 'aaa',
          refreshToken: 'bbb',
        ),
      );

      initModules(
        [
          UiAuthModule(),
          UiCountryModule(),
          UiValidCodeModule(),
        ],
        replaceBinds: [
          Bind.instance<UserRepository>(userRepositoryMock),
        ],
      );

      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("uiAuthCountry")));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Afghanistan"));
      await tester.pumpAndSettle();
      expect(find.text("93"), findsOneWidget);

      await tester.enterText(
        find.byKey(const Key("uiAuthFieldPhone")),
        '999999999',
      );
      await tester.pump();

      var testController = find
          .byKey(const Key("uiAuthFieldPhone"))
          .evaluate()
          .single
          .widget as TextField;

      String text = testController.controller?.text ?? "";
      expect(text, '99-999-9999');

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      Finder finderButton = find.byKey(const Key("uiAuthButtonSend"));
      expect(finderButton, findsOneWidget);
      await tester.tap(finderButton);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key("uiValidCodePage")), findsOneWidget);

      Finder finderTextCode = find.byKey(const Key("uiValidCodeTextCode"));
      expect(finderTextCode, findsOneWidget);
      await tester.enterText(finderTextCode, '123456');

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      Finder finderButtonValid = find.byKey(const Key('uiValidCodeButton'));
      expect(finderButtonValid, findsOneWidget);
      await tester.tap(finderButtonValid);
      await tester.pumpAndSettle(const Duration(seconds: 4));

      Finder finderTextProfile = find.byKey(const Key('uiProfileContainer'));
      expect(finderTextProfile, findsOneWidget);
    },
  );

  testWidgets(
    'when request to valid code fail should show message error',
    (tester) async {
      MockUserRepositoryMock userRepositoryMock = MockUserRepositoryMock();
      when(
        userRepositoryMock.requestCode(any),
      ).thenAnswer((_) async => true);
      when(
        userRepositoryMock.requestValidCode(any),
      ).thenThrow(HttpException.putEnum(HttpErrorEnum.USER_SEND_CODE_INVALID));

      initModules(
        [
          UiAuthModule(),
          UiCountryModule(),
          UiValidCodeModule(),
        ],
        replaceBinds: [
          Bind.instance<UserRepository>(userRepositoryMock),
        ],
      );

      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("uiAuthCountry")));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Afghanistan"));
      await tester.pumpAndSettle();
      expect(find.text("93"), findsOneWidget);

      await tester.enterText(
        find.byKey(const Key("uiAuthFieldPhone")),
        '999999999',
      );
      await tester.pump();

      var testController = find
          .byKey(const Key("uiAuthFieldPhone"))
          .evaluate()
          .single
          .widget as TextField;

      String text = testController.controller?.text ?? "";
      expect(text, '99-999-9999');

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      Finder finderButton = find.byKey(const Key("uiAuthButtonSend"));
      expect(finderButton, findsOneWidget);
      await tester.tap(finderButton);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key("uiValidCodePage")), findsOneWidget);

      Finder finderTextCode = find.byKey(const Key("uiValidCodeTextCode"));
      expect(finderTextCode, findsOneWidget);
      await tester.enterText(finderTextCode, '123456');

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      Finder finderButtonValid = find.byKey(const Key('uiValidCodeButton'));
      expect(finderButtonValid, findsOneWidget);
      await tester.tap(finderButtonValid);
      await tester.pumpAndSettle();

      Finder finderTextProfile = find.byKey(const Key('uiValidCodeMsgError'));
      expect(finderTextProfile, findsWidgets);
    },
  );
}
