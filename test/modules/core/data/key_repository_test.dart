import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/key_repository.dart';
import 'package:portfolio_flutter/modules/core/data/key_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';
import 'package:portfolio_flutter/modules/core/regex/regex.dart';

import 'key_repository_test.mocks.dart';

class KeySPMock extends Mock implements KeySP {}

class RegexMock extends Mock implements Regex {}

@GenerateMocks([
  KeySPMock,
  RegexMock,
])
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late MockKeySPMock keySPMock;
  late MockRegexMock regexMock;
  late KeyRepository keyRepository;

  setUp(() {
    keySPMock = MockKeySPMock();
    regexMock = MockRegexMock();
    keyRepository = KeyRepositoryImpl(sp: keySPMock, regex: regexMock);
  });

  test(
    'when clean router saved should call method',
    () async {
      when(keySPMock.cleanSeed()).thenAnswer((_) async {});
      try {
        keyRepository.cleanSeedSaved();
        expect(true, true);
      } on Exception {
        expect(true, false);
      }
    },
  );

  test(
    'when get key saved should return',
    () async {
      when(keySPMock.getKey()).thenAnswer((_) async => "test");
      try {
        String keySeved = await keyRepository.getKey();
        expect("test", keySeved);
      } on Exception {
        expect(true, false);
      }
    },
  );

  test(
    'when get seed saved',
    () async {
      when(keySPMock.getSeed()).thenAnswer((_) async => "test");
      try {
        String seedSaved = await keyRepository.getSeed();
        expect("test", seedSaved);
      } on Exception {
        expect(true, false);
      }
    },
  );

  test(
    'when but is not saved',
    () async {
      when(keySPMock.getSeed()).thenAnswer((_) async => "");
      when(keySPMock.saveSeed(any)).thenAnswer((_) async {});
      when(regexMock.generateString(regexPattern: anyNamed('regexPattern')))
          .thenAnswer(
        (_) async => "testg",
      );

      try {
        String seedSaved = await keyRepository.getSeed();
        expect("testg", seedSaved);
      } on Exception {
        expect(true, false);
      }
    },
  );
}
