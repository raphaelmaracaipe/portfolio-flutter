import 'package:socket_io_client/socket_io_client.dart' as IO;

abstract class SocketConfig {
  IO.Socket config();
}
