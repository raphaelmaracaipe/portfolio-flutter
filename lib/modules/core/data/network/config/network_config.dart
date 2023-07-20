import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';

class NetworkConfig {
  static Dio config() => Dio(
        BaseOptions(
          contentType: ContentType.json.toString(),
          connectTimeout: const Duration(seconds: 30),
          headers: {
            "x-api-key": _randomApiKey(),
          },
        ),
      );

  static String _randomApiKey() {
    final List<String> keys = [
      'd2e621a6646a4211768cd68e26f21228a81',
      'ca03na188ame03u1d78620de67282882a84'
    ];

    final Random random = Random();
    return keys[random.nextInt(keys.length)];
  }
}
