// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/utils/strings.dart';
import 'package:portfolio_flutter/modules/core/utils/strings_impl.dart';

void main() {
  test(
    'when receiver string with number e text should remove text stay only number',
    () {
      final Strings strings = StringsImpl();
      final String test = strings.onlyNumber("AB123GH123");
      expect(test, "123123");
    },
  );
}
