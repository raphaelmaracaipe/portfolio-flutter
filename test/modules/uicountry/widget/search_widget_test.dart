import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/app_colors.dart';
import 'package:portfolio_flutter/modules/uicountry/widget/search_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "should initialize and build SearchWidget correctly",
    (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: SearchWidget(countries: []),
        ),
      ));

      final backgroundColorFinder = find.byWidgetPredicate(
        (widget) => widget is Material && widget.color == AppColors.colorSearch,
      );
      expect(backgroundColorFinder, findsOneWidget);
    },
  );
}
