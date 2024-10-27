sealed class UiContactBlocEvent {
  const UiContactBlocEvent();
}

final class SendContacts extends UiContactBlocEvent {
  final List<String> contacts;
  SendContacts({required this.contacts});
}
