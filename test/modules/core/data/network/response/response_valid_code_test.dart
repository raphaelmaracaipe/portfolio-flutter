import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';

void main() {
  test('when apply value in model', () {
    final response = ResponseValidCode(accessToken: "a", refreshToken: "b");
    final json = response.toJson();

    expect(json['accessToken'], 'a');
    expect(json['refreshToken'], 'b');
  });
}