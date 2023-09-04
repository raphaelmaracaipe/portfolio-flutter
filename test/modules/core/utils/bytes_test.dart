import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes_impl.dart';

void main() {
  final Bytes bytes = BytesImpl();

  test('when convert string to bytes', () {
    String text = 'test';
    List<int> stringInBytes = bytes.convertStringToBytes(text);
    String stringConverted = bytes.convertBytesToString(stringInBytes);
    expect(stringConverted, text);
  });
}
