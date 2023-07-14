import 'dart:io';

import 'package:dio/dio.dart';

class NetworkConfig {
  static Dio config() => Dio(
        BaseOptions(
          contentType: ContentType.json.toString(),
          headers: {
            "x-api-key": "d2e621a6646a4211768cd68e26f21228a81",
          },
        ),
      );
}
