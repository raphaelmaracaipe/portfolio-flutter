import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/contact_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_contact.dart';
import 'package:portfolio_flutter/modules/uicontacts/bloc/uicontact_bloc.dart';
import 'package:portfolio_flutter/modules/uicontacts/bloc/uicontact_bloc_event.dart';
import 'package:portfolio_flutter/modules/uicontacts/bloc/uicontact_bloc_state.dart';

import 'uicontact_bloc_test.mocks.dart';

class MockContactRepository extends Mock implements ContactRepository {}

@GenerateMocks([MockContactRepository])
void main() {
  late UiContactBloc uiContactBloc;
  late MockMockContactRepository mockContactRepository;

  setUp(() {
    mockContactRepository = MockMockContactRepository();
    uiContactBloc = UiContactBloc(contactRepository: mockContactRepository);
  });

  blocTest<UiContactBloc, UiContactBlocState>(
    'when send list empty with contacts to consult',
    build: () {
      when(mockContactRepository.consult(any)).thenAnswer(
        (_) async => [],
      );
      return uiContactBloc;
    },
    act: (bloc) => bloc.add(SendContacts(contacts: [])),
    expect: () => [UiContactBlocLoading(), const UiContactBlocSuccess([])],
  );

  blocTest<UiContactBloc, UiContactBlocState>(
    'when send list with contacts to consult',
    build: () {
      when(mockContactRepository.consult(any)).thenAnswer(
        (_) async => [
          ResponseContact(
            name: "Test name",
            phone: "555",
            photo: "=123",
          ),
        ],
      );
      return uiContactBloc;
    },
    act: (bloc) => bloc.add(SendContacts(contacts: [
      "555",
      "666",
    ])),
    expect: () => [
      UiContactBlocLoading(),
      UiContactBlocSuccess([
        ResponseContact(
          name: "Test name",
          phone: "555",
          photo: "=123",
        )
      ])
    ],
  );

  blocTest<UiContactBloc, UiContactBlocState>(
    'when send list with contacts but return error',
    build: () {
      when(mockContactRepository.consult(any)).thenThrow(Exception("Error"));
      return uiContactBloc;
    },
    act: (bloc) => bloc.add(SendContacts(contacts: [])),
    expect: () => [
      UiContactBlocLoading(),
      UiContactBlocError(),
    ],
  );
}
