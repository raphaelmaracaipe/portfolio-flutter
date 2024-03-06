import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization_impl.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading_impl.dart';

import 'loading_test.mocks.dart';

class BuildContextMock extends Mock implements BuildContext {}

class ColorUMock extends Mock implements ColorsU {}

@GenerateMocks([ColorUMock])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late BuildContextMock buildContextMock;
  late MockColorUMock colorUMock;

  setUp(() {
    colorUMock = MockColorUMock();
    buildContextMock = BuildContextMock();

    when(
      colorUMock.checkColorsWhichIsDarkMode(
        context: anyNamed('context'),
        light: anyNamed('light'),
        dark: anyNamed('dark'),
      ),
    ).thenReturn(Colors.black);
  });

  testWidgets("when call loading should show loading", (widgetTester) async {
    Loading loading = LoadingImpl();

    AppLocalization appLocalization = AppLocalizationImpl();
    appLocalization.context = buildContextMock;

    await widgetTester.pumpWidget(MaterialApp(
      home: loading.showLoading(appLocalization, colorUMock),
    ));

    expect(find.byKey(const Key("containerLoading")), findsWidgets);
  });
}
