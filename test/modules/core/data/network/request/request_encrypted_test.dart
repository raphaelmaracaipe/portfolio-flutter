import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_encrypted.dart';

void main() {
  test('when add value in map', () async {
    final request = RequestEncrypted(data: "test");
    final json = request.toJson();
    expect(json["data"], "test");
  });
}
