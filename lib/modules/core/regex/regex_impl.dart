import 'package:flutter/services.dart';

import 'regex.dart';

class RegexImpl extends Regex {
  final MethodChannel regexChannel;

  RegexImpl({required this.regexChannel});

  @override
  Future<String> generateString({required String regexPattern}) async {
    try {
      return await regexChannel
          .invokeMethod('regex', {'pattern': regexPattern});
    } on PlatformException catch (e) {
      throw Exception(e.message);
    }
  }
}
