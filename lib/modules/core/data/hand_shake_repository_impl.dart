import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_hand_shake.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_hand_shake.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';
import 'package:portfolio_flutter/modules/core/security/keys.dart';

import 'hand_shake_repository.dart';

class HandShakeRepositoryImpl extends HandShakeRepository {
  final RestHandShake restHandShake;
  final KeySP keySP;
  final Keys key;

  HandShakeRepositoryImpl({
    required this.keySP,
    required this.restHandShake,
    required this.key,
  });

  @override
  Future<void> send() async {
    try {
      if(await keySP.isExistKeyAndIVSaved()) {
        return;
      }

      final keyGenerated = key.generateKey(16);
      await restHandShake.requestHandShake(
        RequestHandShake(
          key: keyGenerated,
        ),
      );

      final seedGenerated = key.generateKey(16);
      await keySP.saveIV(seedGenerated);
      await keySP.saveKey(keyGenerated);
    } on DioException catch (e) {
      throw HttpException(e);
    }
  }
}