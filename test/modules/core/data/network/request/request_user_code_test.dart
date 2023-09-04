import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';

void main() {
  test('when receiver map and transform json', () {
    final Map<String, dynamic> json = {'phone': '1234567890'};
    final RequestUserCode requestUserCode = RequestUserCode.fromJson(json);
    expect(requestUserCode.phone, '1234567890');
  });

  test('when model have phone in param change to map', () {
    final RequestUserCode request = RequestUserCode(phone: '1234567890');
    final String json = request.toJson().toString();
    expect(json, '{phone: 1234567890}');
  });
}
