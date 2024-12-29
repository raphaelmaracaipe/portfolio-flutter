import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/contact_repository.dart';
import 'package:portfolio_flutter/modules/core/data/contact_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/db/daos/contact_dao.dart';
import 'package:portfolio_flutter/modules/core/data/db/entities/contact_entity.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_contact.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_contact.dart';
import 'package:portfolio_flutter/modules/core/data/socket/socket_config.dart';
import 'package:portfolio_flutter/modules/core/utils/contacts.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'contact_repository_test.mocks.dart';

class RestContactMock extends Mock implements RestContact {}

class ContactsMock extends Mock implements Contacts {}

class ContactDaoMock extends Mock implements ContactDao {}

class SockectMock extends Mock implements SocketConfig {}

@GenerateMocks([
  RestContactMock,
  ContactsMock,
  ContactDaoMock,
  SockectMock,
])
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final MockRestContactMock restContactMock = MockRestContactMock();
  final MockContactsMock contactsMock = MockContactsMock();
  final MockContactDaoMock contactDaoMock = MockContactDaoMock();
  final MockSockectMock mockSocket = MockSockectMock();

  setUp(() {
    final ioConnect = io.io('http://localhost', <String, dynamic>{
      'transports': ['websocket'],
    });

    when(mockSocket.config()).thenReturn(ioConnect);
  });

  // test('should connect the socket and return true on success', () async {
  //   // Arrange
  //   when(mockSocket.connect()).thenAnswer((_) => mockSocket);
  //   when(mockSocket.onConnect(any as void Function(dynamic)))
  //       .thenAnswer((invocation) {
  //     final callback =
  //         invocation.positionalArguments[0] as void Function(dynamic);
  //     callback(true);
  //   });

  //   ContactRepository contactRepository = ContactRepositoryImpl(
  //     restContact: restContactMock,
  //     contacts: contactsMock,
  //     contactDao: contactDaoMock,
  //     socket: mockSocket,
  //   );

  //   // Act
  //   final result = await contactRepository.connect();

  //   // Assert
  //   verify(mockSocket.connect()).called(1);
  //   expect(result, true);
  // });

  test('when consult contact and return success', () async {
    List<ResponseContact> contacts = [
      ResponseContact(name: "test", phone: "phone", photo: "photo")
    ];

    when(contactDaoMock.countUsePhone(any)).thenAnswer((_) async => 0);
    when(contactDaoMock.updatePhoto(any, any)).thenAnswer((_) async => {});
    when(contactDaoMock.insert(any)).thenAnswer((_) async => {});
    when(contactDaoMock.getAll()).thenAnswer(
      (_) async => [
        ContactEntity(
          phone: "559",
          name: "test",
          photo: "photo",
        )
      ],
    );
    when(
      restContactMock.consult(any),
    ).thenAnswer((_) async => contacts);
    when(
      contactsMock.requestPermission(),
    ).thenAnswer((_) async => true);
    when(
      contactsMock.getContacts(
        withProperties: anyNamed("withProperties"),
        withThumbnail: anyNamed("withThumbnail"),
        withPhoto: anyNamed("withPhoto"),
        withGroups: anyNamed("withGroups"),
        withAccounts: anyNamed("withAccounts"),
        sorted: anyNamed("sorted"),
        deduplicateProperties: anyNamed("deduplicateProperties"),
      ),
    ).thenAnswer(
      (_) async => [
        Contact(
          phones: [
            Phone("555"),
          ],
        )
      ],
    );

    ContactRepository contactRepository = ContactRepositoryImpl(
      restContact: restContactMock,
      contacts: contactsMock,
      contactDao: contactDaoMock,
      socketConfig: mockSocket,
    );

    try {
      final contactConsulted = await contactRepository.consult();
      expect(contactConsulted.length, 1);
    } on Exception catch (_) {
      expect(false, true);
    }
  });

  test('when consult contact but return exception http', () async {
    when(contactDaoMock.insert(any)).thenAnswer((_) async => {});
    when(contactDaoMock.getAll()).thenAnswer(
      (_) async => [
        ContactEntity(
          phone: "559",
          name: "test",
          photo: "photo",
        )
      ],
    );
    when(
      restContactMock.consult(any),
    ).thenThrow(DioException(requestOptions: RequestOptions()));
    when(
      contactsMock.requestPermission(),
    ).thenAnswer((_) async => true);
    when(
      contactsMock.getContacts(
        withProperties: anyNamed("withProperties"),
        withThumbnail: anyNamed("withThumbnail"),
        withPhoto: anyNamed("withPhoto"),
        withGroups: anyNamed("withGroups"),
        withAccounts: anyNamed("withAccounts"),
        sorted: anyNamed("sorted"),
        deduplicateProperties: anyNamed("deduplicateProperties"),
      ),
    ).thenAnswer(
      (_) async => [
        Contact(
          phones: [
            Phone("555"),
          ],
        )
      ],
    );

    ContactRepository contactRepository = ContactRepositoryImpl(
      restContact: restContactMock,
      contacts: contactsMock,
      contactDao: contactDaoMock,
      socketConfig: mockSocket,
    );

    try {
      await contactRepository.consult();
      expect(false, true);
    } on Exception {
      expect(true, true);
    }
  });

  test('when consult contact but return exception generic', () async {
    when(contactDaoMock.insert(any)).thenAnswer((_) async => {});
    when(contactDaoMock.getAll()).thenAnswer(
      (_) async => [
        ContactEntity(
          phone: "559",
          name: "test",
          photo: "photo",
        )
      ],
    );
    when(
      restContactMock.consult(any),
    ).thenThrow(Exception());
    when(
      contactsMock.requestPermission(),
    ).thenAnswer((_) async => true);
    when(
      contactsMock.getContacts(
        withProperties: anyNamed("withProperties"),
        withThumbnail: anyNamed("withThumbnail"),
        withPhoto: anyNamed("withPhoto"),
        withGroups: anyNamed("withGroups"),
        withAccounts: anyNamed("withAccounts"),
        sorted: anyNamed("sorted"),
        deduplicateProperties: anyNamed("deduplicateProperties"),
      ),
    ).thenAnswer(
      (_) async => [
        Contact(
          phones: [
            Phone("555"),
          ],
        )
      ],
    );

    ContactRepository contactRepository = ContactRepositoryImpl(
      restContact: restContactMock,
      contacts: contactsMock,
      contactDao: contactDaoMock,
      socketConfig: mockSocket,
    );

    try {
      await contactRepository.consult();
      expect(false, true);
    } on Exception {
      expect(true, true);
    }
  });

  test('when consult list of contacts but return error.', () async {
    List<ResponseContact> contacts = [
      ResponseContact(name: "test", phone: "phone", photo: "photo")
    ];

    when(contactDaoMock.countUsePhone(any)).thenAnswer((_) async => 0);
    when(contactDaoMock.updatePhoto(any, any)).thenAnswer((_) async => {});
    when(contactDaoMock.insert(any)).thenAnswer((_) async => {});
    when(contactDaoMock.getAll()).thenAnswer(
      (_) async => [
        ContactEntity(
          phone: "559",
          name: "test",
          photo: "photo",
        )
      ],
    );
    when(
      restContactMock.consult(any),
    ).thenAnswer((_) async => contacts);
    when(
      contactsMock.requestPermission(),
    ).thenAnswer((_) async => true);
    when(
      contactsMock.getContacts(
        withProperties: anyNamed("withProperties"),
        withThumbnail: anyNamed("withThumbnail"),
        withPhoto: anyNamed("withPhoto"),
        withGroups: anyNamed("withGroups"),
        withAccounts: anyNamed("withAccounts"),
        sorted: anyNamed("sorted"),
        deduplicateProperties: anyNamed("deduplicateProperties"),
      ),
    ).thenAnswer(
      (_) async => [
        Contact(
          phones: [
            Phone("555"),
          ],
        )
      ],
    );

    ContactRepository contactRepository = ContactRepositoryImpl(
      restContact: restContactMock,
      contacts: contactsMock,
      contactDao: contactDaoMock,
      socketConfig: mockSocket,
    );

    try {
      await contactRepository.consult();
      expect(false, true);
    } on Exception {
      expect(true, true);
    }
  });

  test('when consult list of contacts but list empty.', () async {
    when(contactDaoMock.insert(any)).thenAnswer((_) async => {});
    when(contactDaoMock.getAll()).thenAnswer(
      (_) async => [
        ContactEntity(
          phone: "559",
          name: "test",
          photo: "photo",
        )
      ],
    );
    when(
      contactsMock.requestPermission(),
    ).thenAnswer((_) async => false);
    when(
      contactsMock.getContacts(
        withProperties: anyNamed("withProperties"),
        withThumbnail: anyNamed("withThumbnail"),
        withPhoto: anyNamed("withPhoto"),
        withGroups: anyNamed("withGroups"),
        withAccounts: anyNamed("withAccounts"),
        sorted: anyNamed("sorted"),
        deduplicateProperties: anyNamed("deduplicateProperties"),
      ),
    ).thenAnswer(
      (_) async => [
        Contact(
          phones: [
            Phone("555"),
          ],
        )
      ],
    );

    ContactRepository contactRepository = ContactRepositoryImpl(
      restContact: restContactMock,
      contacts: contactsMock,
      contactDao: contactDaoMock,
      socketConfig: mockSocket,
    );

    try {
      await contactRepository.consult();
      expect(false, true);
    } on Exception {
      expect(true, true);
    }
  });

  test('when consult list of contacts and update', () async {
    List<ResponseContact> contacts = [
      ResponseContact(name: "test", phone: "phone", photo: "photo")
    ];

    // when(contactDaoMock.insert(any)).thenAnswer((_) async => {});
    when(contactDaoMock.countUsePhone(any)).thenAnswer((_) async => 1);
    when(contactDaoMock.updatePhoto(any, any)).thenAnswer((_) async {});
    when(contactDaoMock.getAll()).thenAnswer(
      (_) async => [
        ContactEntity(
          phone: "559",
          name: "test",
          photo: "photo",
        )
      ],
    );
    when(
      contactsMock.requestPermission(),
    ).thenAnswer((_) async => true);
    when(
      contactsMock.getContacts(
        withProperties: anyNamed("withProperties"),
        withThumbnail: anyNamed("withThumbnail"),
        withPhoto: anyNamed("withPhoto"),
        withGroups: anyNamed("withGroups"),
        withAccounts: anyNamed("withAccounts"),
        sorted: anyNamed("sorted"),
        deduplicateProperties: anyNamed("deduplicateProperties"),
      ),
    ).thenAnswer(
      (_) async => [
        Contact(
          phones: [
            Phone("555"),
          ],
        )
      ],
    );
    when(
      restContactMock.consult(any),
    ).thenAnswer((_) async => contacts);

    ContactRepository contactRepository = ContactRepositoryImpl(
      restContact: restContactMock,
      contacts: contactsMock,
      contactDao: contactDaoMock,
      socketConfig: mockSocket,
    );

    try {
      await contactRepository.consult();
      expect(false, true);
    } on Exception {
      expect(true, true);
    }
  });

  test('when need consult list of contacts save local', () async {
    when(contactDaoMock.getAll()).thenAnswer((_) async => []);

    ContactRepository contactRepository = ContactRepositoryImpl(
      restContact: restContactMock,
      contacts: contactsMock,
      contactDao: contactDaoMock,
      socketConfig: mockSocket,
    );

    final listOfContacts = await contactRepository.consultOffline();
    expect([], listOfContacts);
  });

  test(
    'when consult contact used number phone should return information',
    () async {
      when(contactDaoMock.getContactByPhone(any)).thenAnswer(
        (_) async => ContactEntity(
          phone: "559",
          name: "test",
          photo: "photo",
        ),
      );

      ContactRepository contactRepository = ContactRepositoryImpl(
        restContact: restContactMock,
        contacts: contactsMock,
        contactDao: contactDaoMock,
        socketConfig: mockSocket,
      );

      final count = await contactRepository.getContactByPhone("559");
      expect("559", count.phone);
    },
  );
}
