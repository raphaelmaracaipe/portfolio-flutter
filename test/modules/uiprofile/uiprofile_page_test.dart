import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/uiprofile/uiprofile_page.dart';

void main() {
  testWidgets('when init view', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: UiProfilePage(),
    ));
    await widgetTester.pump();

    final Finder uiProfileContainer = find.byKey(
      const Key('uiProfileContainer'),
    );
    expect(uiProfileContainer, findsOneWidget);
  });
}
