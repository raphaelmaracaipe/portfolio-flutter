import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/widgets/bottomsheet/bottom_sheet.dart';
import 'package:portfolio_flutter/modules/core/widgets/bottomsheet/bottom_sheet_impl.dart';

class BuildContextMock extends Mock implements BuildContext {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'when show bottomsheet and click em button should return callback',
    (widgetTester) async {
      final Bottomsheet bottomsheet = BottomsheetImpl();

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElevatedButton(
              key: const Key('TestElevatedButton'),
              onPressed: () {
                bottomsheet.show(
                  context: widgetTester.element(find.text('test')),
                  title: 'aaa',
                  text: 'bbb',
                  btnText: 'ccc',
                  onBtnClick: () {
                    expect(true, true);
                  },
                );
              },
              child: const Text(
                "test",
              ),
            ),
          ),
        ),
      );

      await widgetTester.tap(find.byKey(const Key('TestElevatedButton')));
      await widgetTester.pumpAndSettle();

      expect(find.byKey(const Key('bottomSheetContainer')), findsOneWidget);

      await widgetTester.tap(find.byKey(const Key('bottomSheetClickButton')));
      await widgetTester.pumpAndSettle();
    },
  );
}
