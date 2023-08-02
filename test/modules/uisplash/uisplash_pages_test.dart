import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';
import 'package:portfolio_flutter/modules/uisplash/uisplash_module.dart';
import 'package:portfolio_flutter/modules/uisplash/uisplash_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('when init check if is show container', (widgetTester) async {
    initModule(UiSplashModule());

    UiSplashPage page = UiSplashPage();
    await widgetTester.pumpWidget(MaterialApp(
      home: page,
    ));
    await widgetTester.pump(const Duration(seconds: 5));

    Finder findContainer = find.byKey(const Key('uisplash_container'));
    expect(findContainer, findsOneWidget);
  });
}
