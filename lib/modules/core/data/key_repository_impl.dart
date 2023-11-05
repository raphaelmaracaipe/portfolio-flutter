import 'package:portfolio_flutter/modules/core/const/regex_const.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';
import 'package:portfolio_flutter/modules/core/regex/regex.dart';

import 'key_repository.dart';

class KeyRepositoryImpl extends KeyRepository {
  late final KeySP _keySP;
  late final Regex _regex;

  KeyRepositoryImpl({required KeySP sp, required Regex regex})
      : _keySP = sp,
        _regex = regex;

  @override
  Future<void> cleanSeedSaved() async => await _keySP.cleanSeed();

  @override
  Future<String> getKey() async => _keySP.getKey();

  @override
  Future<String> getSeed() async {
    final seed = await _keySP.getSeed();
    if(seed.isNotEmpty) {
      return seed;
    }

    final seedGeneretedUsingRegex = await _regex.generateString(
      regexPattern: regexSeed
    );

    await _keySP.saveSeed(seedGeneretedUsingRegex);
    return seedGeneretedUsingRegex;
  }
}
