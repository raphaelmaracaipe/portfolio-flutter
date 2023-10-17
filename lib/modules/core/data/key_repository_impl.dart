import 'package:injectable/injectable.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';

import 'key_repository.dart';

@Injectable(as: KeyRepository)
class KeyRepositoryImpl extends KeyRepository {
  late final KeySP _keySP;

  KeyRepositoryImpl({required KeySP sp}) : 
    _keySP = sp;

  @override
  Future<void> cleanSeedSaved() async => await _keySP.cleanSeed();

}