sealed class UiValidCodeBlocEvent {
  const UiValidCodeBlocEvent();
}

final class SendCodeToValidationEvent extends UiValidCodeBlocEvent {
  final String code;
  SendCodeToValidationEvent({required this.code});
}
