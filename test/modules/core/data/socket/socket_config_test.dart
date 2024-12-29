import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/data/socket/socket_config.dart';
import 'package:portfolio_flutter/modules/core/data/socket/socket_config_impl.dart';

void main() {
  test('when connect socket', () {
    final SocketConfig socketConfig = SocketConfigImpl();
    expect(socketConfig.config(), isNotNull);
  });
}
