import 'dart:math';

import 'package:portfolio_flutter/modules/core/utils/strings.dart';

class StringsImpl extends Strings {
  @override
  String onlyNumber(String text) {
    final RegExp regex = RegExp(r'\D');
    return text.replaceAll(regex, '');
  }

  @override
  String generateRandomString(int length) {
    final random = Random();
    const char =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

    return List.generate(
      length,
      (index) => char[random.nextInt(char.length)],
    ).join();
  }
}
