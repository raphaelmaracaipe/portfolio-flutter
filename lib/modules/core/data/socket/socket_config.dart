import 'package:socket_io_client/socket_io_client.dart' as io;

abstract class SocketConfig {
  io.Socket config();
}
