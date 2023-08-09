import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_hand_shake.dart';

void main() {
  test('when apply value in model', () async {
    final requestHandShake = RequestHandShake(key: "test");
    final json = requestHandShake.toJson();
    expect(json['key'], "test");
  });
}