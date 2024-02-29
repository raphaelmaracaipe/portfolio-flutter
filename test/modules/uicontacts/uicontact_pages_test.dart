import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/uicontacts/uicontact_pages.dart';

import '../uicountry/uicountry_page_test.mocks.dart';

class StackRouterMock extends Mock implements StackRouter {}

@GenerateMocks([
  StackRouterMock,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockStackRouterMock stackRouterMock;

  setUp(() {
    stackRouterMock = MockStackRouterMock();
  });

  testWidgets('when init page', (widgetTester) async {
    await widgetTester.runAsync(() async {
      await widgetTester.pumpWidget(MaterialApp(
        home: StackRouterScope(
          controller: stackRouterMock,
          stateHash: 0,
          child: const UiContactPages(),
        ),
      ));
      await widgetTester.pumpAndSettle();

      final Finder uiContactPagesTest = find.byKey(
        const Key("UiContactPagesTest"),
      );

      expect(uiContactPagesTest, findsOneWidget);
    });
  });
}
