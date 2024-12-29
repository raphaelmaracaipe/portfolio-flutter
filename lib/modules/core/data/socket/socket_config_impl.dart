import 'package:injectable/injectable.dart';
import 'package:portfolio_flutter/config/app_api.dart';
import 'package:portfolio_flutter/modules/core/data/socket/socket_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

@Injectable(as: SocketConfig)
class SocketConfigImpl extends SocketConfig {
  @override
  IO.Socket config() {
    return IO.io(
      "${AppApi.baseSocketURL}/contact-status",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );
  }
}
