import 'package:portfolio_flutter/modules/uimessage/bloc/uimessage_bloc_status.dart';

abstract class UIMessageBlocState {
  final UiMessageBlocStatus status;

  const UIMessageBlocState({
    required this.status,
  });
}

class UIMessageBlocEventUnknown extends UIMessageBlocState {
  const UIMessageBlocEventUnknown()
      : super(
          status: UiMessageBlocStatus.unknown,
        );
}

class UIMessageBlocEventHeIsOnline extends UIMessageBlocState {
  const UIMessageBlocEventHeIsOnline()
      : super(
          status: UiMessageBlocStatus.heIsOnline,
        );
}

class UIMessageBlocEventConnected extends UIMessageBlocState {
  const UIMessageBlocEventConnected()
      : super(
          status: UiMessageBlocStatus.connected,
        );
}

class UIMessageBlocEventDisconnected extends UIMessageBlocState {
  const UIMessageBlocEventDisconnected()
      : super(
          status: UiMessageBlocStatus.disconnect,
        );
}
