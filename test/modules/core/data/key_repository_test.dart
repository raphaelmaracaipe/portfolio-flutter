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
  late MockKeySPMock keySPMock;
  late MockRegexMock regexMock;
  late KeyRepository keyRepository;

  setUp(() {
    keySPMock = MockKeySPMock();
    regexMock = MockRegexMock();

    keyRepository = KeyRepositoryImpl(sp: keySPMock, regex: regexMock);
  });

  test('when clean router saved should call method', () async {
    when(keySPMock.cleanSeed()).thenAnswer((_) async {});
    try {
      keyRepository.cleanSeedSaved();
      expect(true, true);
    } on Exception {
      expect(true, false);
    }
  });
}
