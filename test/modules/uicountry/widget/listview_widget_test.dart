import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/uicountry/widget/listview_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("ListViewWidget", () {
    testWidgets(
      "when list of countries empty should not show items",
      (widgetTester) async {
        ListViewWidget listViewWidget = ListViewWidget(countries: []);
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
  });
}
