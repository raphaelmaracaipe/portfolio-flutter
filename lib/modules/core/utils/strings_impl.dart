import 'package:portfolio_flutter/modules/core/utils/strings.dart';

class StringsImpl extends Strings {
  @override
  String onlyNumber(String text) {
    final RegExp regex = RegExp(r'\D');
    return text.replaceAll(regex, '');
  }
}
