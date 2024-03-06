import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/uicountry/widget/listview_widget.dart';

import 'listview_widget_test.mocks.dart';

class ColorUMock extends Mock implements ColorsU {}

@GenerateMocks([ColorUMock])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockColorUMock colorUMock;

  setUp(() {
    colorUMock = MockColorUMock();

    GetIt.instance.allowReassignment = true;
    GetIt.instance.registerSingleton<ColorsU>(colorUMock);

    when(
      colorUMock.checkColorsWhichIsDarkMode(
        context: anyNamed('context'),
        light: anyNamed('light'),
        dark: anyNamed('dark'),
      ),
    ).thenReturn(Colors.black);
  });

  testWidgets(
    "when list of countries empty should not show items",
    (widgetTester) async {
      ListViewWidget listViewWidget = ListViewWidget(countries: const []);
      await widgetTester.pumpWidget(MaterialApp(
        home: listViewWidget,
      ));

      expect(
        find.byKey(const Key("listViewUiCountryContainer")),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key("listViewUiCountryItemRow")),
        findsNothing,
      );
    },
  );

  testWidgets(
    "when list of countries with data should show items of listview",
    (widgetTester) async {
      List<CountryModel> countries = [
        CountryModel(
          codeCountry: "AAA",
          countryName: "BBB",
          codeIson: "CCC",
          mask: "DDD",
        )
      ];

      ListViewWidget listViewWidget = ListViewWidget(countries: countries);
      await widgetTester.pumpWidget(MaterialApp(
        home: listViewWidget,
      ));

      expect(
        find.byKey(const Key("listViewUiCountryContainer")),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key("listViewUiCountryItemRow")),
        findsWidgets,
      );
    },
  );
}
