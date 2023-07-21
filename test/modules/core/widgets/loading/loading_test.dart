import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization_impl.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading_impl.dart';

class BuildContextMock extends Mock implements BuildContext {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  BuildContextMock buildContextMock = BuildContextMock();

  testWidgets("when call loading should show loading", (widgetTester) async {
    Loading loading = LoadingImpl();

    AppLocalization appLocalization = AppLocalizationImpl();
    appLocalization.context = buildContextMock;

    await widgetTester.pumpWidget(MaterialApp(
      home: loading.showLoading(appLocalization),
    ));

    expect(find.byKey(const Key("containerLoading")), findsWidgets);
  });
}
