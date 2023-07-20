import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("when call loading should show loading", (widgetTester) async {
    Loading loading = LoadingImpl();
    await widgetTester.pumpWidget(MaterialApp(
      home: loading.showLoading(),
    ));

    expect(find.byKey(const Key("containerLoading")), findsWidgets);
  });
}
