import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:portfolio_flutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("authTest", () {
    testWidgets(
      "when tap in countries should show code, flag and name in fields",
      (tester) async {
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
  });
}
