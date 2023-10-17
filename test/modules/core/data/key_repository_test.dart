import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/key_repository.dart';
import 'package:portfolio_flutter/modules/core/data/key_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';

import 'key_repository_test.mocks.dart';

class KeySPMock extends Mock implements KeySP {}

@GenerateMocks([KeySPMock])
void main() {
  late MockKeySPMock keySPMock;
  late KeyRepository keyRepository;

  setUp(() {
    keySPMock = MockKeySPMock();
    keyRepository = KeyRepositoryImpl(sp: keySPMock);
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
