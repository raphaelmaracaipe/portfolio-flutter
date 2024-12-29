import 'package:injectable/injectable.dart';
import 'package:portfolio_flutter/config/app_api.dart';
import 'package:portfolio_flutter/modules/core/data/socket/socket_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

@Injectable(as: SocketConfig)
class SocketConfigImpl extends SocketConfig {
  @override
  io.Socket config() {
    return io.io(
      "${AppApi.baseSocketURL}/contact-status",
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );
  }
}
