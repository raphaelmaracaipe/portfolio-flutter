import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/uicountry/widget/loading_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("LoadingWidget", () {
    testWidgets(
      "when check if container is show",
      (widgetTester) async {
        LoadingWidget loadingWidget = const LoadingWidget();
        await widgetTester.pumpWidget(MaterialApp(
          home: loadingWidget,
        ));

        expect(find.byKey(const Key("containerLoading")), findsWidgets);
      },
    );
  });
}
