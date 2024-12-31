import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/const/regex_const.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_hand_shake.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_hand_shake.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';
import 'package:portfolio_flutter/modules/core/regex/regex.dart';

import 'hand_shake_repository.dart';

class HandShakeRepositoryImpl extends HandShakeRepository {
  final RestHandShake restHandShake;
  final KeySP keySP;
  final Regex regex;

  HandShakeRepositoryImpl({
    required this.keySP,
    required this.restHandShake,
    required this.regex,
  });

  @override
  Future<void> send() async {
    try {
      if (await keySP.isExistKeyAndIVSaved()) {
        return;
      }

      final keyGenerated = await regex.generateString(regexPattern: regexKey);
      await restHandShake.requestHandShake(
        RequestHandShake(
          key: keyGenerated,
        ),
      );

      await keySP.saveKey(keyGenerated);
    } on DioException catch (e) {
      throw HttpException(exception: e);
    } on Exception catch (_) {
      throw HttpException(errorEnum: HttpErrorEnum.ERROR_GENERAL);
    }
  }
}
