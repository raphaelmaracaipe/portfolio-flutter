import 'dart:convert';

import 'bytes.dart';

class BytesImpl extends Bytes {
  @override
  String convertBytesToString(
    List<int> bytes, {
    String encoding = 'utf-8',
  }) =>
      utf8.decode(bytes);

  @override
  List<int> convertStringToBytes(
    String input, {
    String encoding = 'utf-8',
  }) =>
      utf8.encode(input);
}
