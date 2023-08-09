import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/security/keys.dart';
import 'package:portfolio_flutter/modules/core/security/keys_impl.dart';

void main() {
  test('when init generation of key', () async {
    final Keys keys = KeysImpl();
    final String keyGenerated = keys.generateKey(20);
    expect(keyGenerated.length, 20);
  });
}