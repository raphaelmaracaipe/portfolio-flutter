import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/contact_repository.dart';
import 'package:portfolio_flutter/modules/core/data/contact_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_contact.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_contact.dart';
import 'package:portfolio_flutter/modules/core/utils/contacts.dart';

import 'contact_repository_test.mocks.dart';

class RestContactMock extends Mock implements RestContact {}

class ContactsMock extends Mock implements Contacts {}

@GenerateMocks([RestContactMock, ContactsMock])
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final MockRestContactMock restContactMock = MockRestContactMock();
  final MockContactsMock contactsMock = MockContactsMock();

  test('when consult contact and return success', () async {
    List<ResponseContact> contacts = [
      ResponseContact(name: "test", phone: "phone", photo: "photo")
    ];

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
    );

    try {
      final contactConsulted = await contactRepository.consult(["444", "555"]);
      expect(contactConsulted.length, 1);
    } on Exception catch (e) {
      expect(false, true);
    }
  });

  test('when consult contact but return exception http', () async {
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
    );

    try {
      await contactRepository.consult(["444", "555"]);
      expect(false, true);
    } on Exception {
      expect(true, true);
    }
  });

  test('when consult contact but return exception generic', () async {
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
    );

    try {
      await contactRepository.consult(["444", "555"]);
      expect(false, true);
    } on Exception {
      expect(true, true);
    }
  });

  test('when consult list of contacts but return error.', () async {
    List<ResponseContact> contacts = [
      ResponseContact(name: "test", phone: "phone", photo: "photo")
    ];

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
    );

    try {
      await contactRepository.consult(["444", "555"]);
      expect(false, true);
    } on Exception {
      expect(true, true);
    }
  });

  test('when consult list of contacts but list empty.', () async {
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
    );

    try {
      await contactRepository.consult(["444", "555"]);
      expect(false, true);
    } on Exception {
      expect(true, true);
    }
  });
}
