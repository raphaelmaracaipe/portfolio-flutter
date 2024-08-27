import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_impl.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';

void main() {
  testWidgets(
    'Testa o checkColorsWhichIsDarkMode',
    (WidgetTester tester) async {
      const lightColor = Colors.white;
      const darkColor = Colors.black;

      ColorsU colorsUImpl = ColorsUImpl();

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Builder(
            builder: (BuildContext context) {
              final result = colorsUImpl.checkColorsWhichIsDarkMode(
                context: context,
                light: lightColor,
                dark: darkColor,
              );
              expect(result, lightColor);
              return Container();
            },
          ),
        ),
      );
    },
  );
}
