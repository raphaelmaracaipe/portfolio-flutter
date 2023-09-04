import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization_impl.dart';
import 'package:portfolio_flutter/modules/uicountry/widget/search_widget.dart';

class BuildContextMock extends Mock implements BuildContext {}

@GenerateMocks([])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppLocalization appLocalization;

  setUp(() {
    appLocalization = AppLocalizationImpl();
    appLocalization.context = BuildContextMock();
  });

  testWidgets(
    "should initialize and build SearchWidget correctly",
    (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SearchWidget(
            countries: const [],
            appLocalization: appLocalization,
          ),
        ),
      ));

      final backgroundColorFinder = find.byWidgetPredicate(
        (widget) => widget is Material && widget.color == AppColors.colorSearch,
      );
      expect(backgroundColorFinder, findsOneWidget);
    },
  );
}
