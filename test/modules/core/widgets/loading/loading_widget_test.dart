import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization_impl.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading_widget.dart';

class BuildContextMock extends Mock implements BuildContext {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "when check if container is show",
    (widgetTester) async {
      AppLocalization appLocalization = AppLocalizationImpl();
      appLocalization.context = BuildContextMock();

      LoadingWidget loadingWidget = LoadingWidget(
        appLocalization: appLocalization,
      );

      await widgetTester.pumpWidget(MaterialApp(
        home: loadingWidget,
      ));

      expect(find.byKey(const Key("containerLoading")), findsWidgets);
    },
  );
}
