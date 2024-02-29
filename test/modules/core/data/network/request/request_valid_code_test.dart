import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_valid_code.dart';

void main() {
  test('when apply value in model', () async {
    final request = RequestValidCode(code: "test");
    final json = request.toJson();
    expect(json['code'], 'test');
  });

  test('when received json and convert to model', () {
    const code = "12345";
    final json = {'code': code};

    final requestValidCode = RequestValidCode.fromJson(json);
    expect(code, requestValidCode.code);
  });
}
