import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/uimessage/bloc/uimessage_bloc.dart';
import 'package:portfolio_flutter/modules/uimessage/bloc/uimessage_bloc_state.dart';
import 'package:portfolio_flutter/modules/uimessage/uimessage_page.dart';

import 'uimessage_page_test.mocks.dart';

class StackRouterMock extends Mock implements StackRouter {}

class ColorUMock extends Mock implements ColorsU {}

class AppLocalizationMock extends Mock implements AppLocalization {}

class UiMessageBlocMock extends Mock implements UIMessageBloc {}

@GenerateMocks([
  StackRouterMock,
  ColorUMock,
  AppLocalizationMock,
  UiMessageBlocMock,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockStackRouterMock stackRouterMock;
  late MockColorUMock colorUMock;
  late MockAppLocalizationMock appLocalizationMock;
  late MockUiMessageBlocMock uiMessageBlocMock;

  setUp(() {
    stackRouterMock = MockStackRouterMock();
    colorUMock = MockColorUMock();
    appLocalizationMock = MockAppLocalizationMock();
    uiMessageBlocMock = MockUiMessageBlocMock();

    GetIt.instance.allowReassignment = true;
    GetIt.instance.registerSingleton<ColorsU>(colorUMock);
    GetIt.instance.registerSingleton<AppLocalization>(appLocalizationMock);
    GetIt.instance.registerSingleton<StackRouter>(stackRouterMock);
    GetIt.instance.registerSingleton<UIMessageBloc>(uiMessageBlocMock);

    when(appLocalizationMock.localization).thenReturn(null);
    when(
      colorUMock.checkColorsWhichIsDarkMode(
        context: anyNamed('context'),
        light: anyNamed('light'),
        dark: anyNamed('dark'),
      ),
    ).thenReturn(Colors.black);
  });

  testWidgets(
    'UiMessagePages displays search and list view',
    (WidgetTester tester) async {
      when(uiMessageBlocMock.stream).thenAnswer(
        (_) => const Stream<UIMessageBlocState>.empty(),
      );
      when(uiMessageBlocMock.state).thenReturn(
        const UIMessageBlocEventUnknown(),
      );

      final contactEntity = ContactEntity(
        name: 'name',
        phone: 'phone',
        photo: 'photo',
      );

      await tester.pumpWidget(MaterialApp(
        home: UiMessagePages(
          contact: contactEntity,
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
    },
  );
}
