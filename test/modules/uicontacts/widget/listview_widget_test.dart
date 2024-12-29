import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/contact_repository.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/uicontacts/widget/listview_widget.dart';

import 'listview_widget_test.mocks.dart';

class ColorUMock extends Mock implements ColorsU {}

class ContactRepositoryMock extends Mock implements ContactRepository {}

@GenerateMocks([
  ColorUMock,
  ContactRepositoryMock,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockColorUMock colorUMock;
  late MockContactRepositoryMock contactRepositoryMock;

  setUp(() {
    colorUMock = MockColorUMock();
    contactRepositoryMock = MockContactRepositoryMock();

    GetIt.instance.allowReassignment = true;
    GetIt.instance.registerSingleton<ColorsU>(colorUMock);
    GetIt.instance.registerSingleton<ContactRepository>(contactRepositoryMock);

    when(
      colorUMock.checkColorsWhichIsDarkMode(
        context: anyNamed('context'),
        light: anyNamed('light'),
        dark: anyNamed('dark'),
      ),
    ).thenReturn(Colors.black);
  });

  testWidgets(
    "when list of contacts is empty should not show items",
    (widgetTester) async {
      ListViewWidget listViewWidget = ListViewWidget(
        contacts: const [],
        colorsU: colorUMock,
        contactRepository: contactRepositoryMock,
      );
      await widgetTester.pumpWidget(MaterialApp(
        home: listViewWidget,
      ));

      expect(
        find.byKey(const Key("listViewWidgetUiContanct")),
        findsOneWidget,
      );
      expect(
        find.byType(GestureDetector),
        findsNothing,
      );
    },
  );

  testWidgets(
    "when list of contacts with data should show items of listview",
    (widgetTester) async {
      List<ContactEntity> contacts = [
        ContactEntity(
          phone: "1234567890",
          name: "John Doe",
          reminder: "Meeting at 10 AM",
          photo: null,
        )
      ];

      ListViewWidget listViewWidget = ListViewWidget(
        contacts: contacts,
        colorsU: colorUMock,
        contactRepository: contactRepositoryMock,
      );
      await widgetTester.pumpWidget(MaterialApp(
        home: listViewWidget,
      ));

      expect(
        find.byKey(const Key("listViewWidgetUiContanct")),
        findsOneWidget,
      );
      expect(
        find.byType(GestureDetector),
        findsWidgets,
      );
    },
  );
}
