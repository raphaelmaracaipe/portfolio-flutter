sealed class UiMessageBlocEvent {
  const UiMessageBlocEvent();
}

final class UiMessageBlocEventHeIsOnline extends UiMessageBlocEvent {
  final String phone;
  UiMessageBlocEventHeIsOnline(this.phone);
}

final class UIMessageEventBlocConnect extends UiMessageBlocEvent {}

final class UIMessageEventBlocDisconnect extends UiMessageBlocEvent {}
