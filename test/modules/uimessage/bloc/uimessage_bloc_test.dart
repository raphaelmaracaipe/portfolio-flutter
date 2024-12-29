import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/contact_repository.dart';
import 'package:portfolio_flutter/modules/uimessage/bloc/uimessage_bloc.dart';
import 'package:portfolio_flutter/modules/uimessage/bloc/uimessage_bloc_event.dart';
import 'package:portfolio_flutter/modules/uimessage/bloc/uimessage_bloc_state.dart';

import 'uimessage_bloc_test.mocks.dart';

class ContactRepositoryMock extends Mock implements ContactRepository {}

@GenerateMocks([
  ContactRepositoryMock,
])
void main() {
  late UIMessageBloc uIMessageBloc;
  late MockContactRepositoryMock contactRepositoryMock;

  setUp(() {
    contactRepositoryMock = MockContactRepositoryMock();

    uIMessageBloc = UIMessageBloc(
      contactRepository: contactRepositoryMock,
    );
  });

  blocTest<UIMessageBloc, UIMessageBlocState>(
    'when check status',
    build: () {
      when(contactRepositoryMock.onIAmOnline(
              phoneNumber: anyNamed('phoneNumber')))
          .thenReturn(null);
      when(contactRepositoryMock.checkStatus(
              phoneNumber: anyNamed('phoneNumber')))
          .thenReturn(null);
      when(contactRepositoryMock.onIsHeOnline(
        phoneNumber: anyNamed('phoneNumber'),
        callback: anyNamed('callback'),
      )).thenAnswer((_) async {});
      return uIMessageBloc;
    },
    act: (bloc) => bloc.add(UiMessageBlocEventHeIsOnline('phone')),
    expect: () => [],
  );

  blocTest(
    'when check is online of sockect',
    build: () {
      when(contactRepositoryMock.connect()).thenAnswer((_) async => true);
      return uIMessageBloc;
    },
    act: (bloc) => bloc.add(UIMessageEventBlocConnect()),
    expect: () => [const UIMessageBlocEventConnected()],
  );

  blocTest(
    'when check is disconnect of sockect',
    build: () {
      when(contactRepositoryMock.disconnect()).thenAnswer((_) async => true);
      return uIMessageBloc;
    },
    act: (bloc) => bloc.add(UIMessageEventBlocDisconnect()),
    expect: () => [const UIMessageBlocEventDisconnected()],
  );
}
