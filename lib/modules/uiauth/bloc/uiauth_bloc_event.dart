sealed class UiAuthBlocEvent {
  const UiAuthBlocEvent();
}

final class GetListOfCountriesInAuth extends UiAuthBlocEvent {}

final class CheckRoute extends UiAuthBlocEvent {}

final class SendToRequestCode extends UiAuthBlocEvent {
  final String phoneNumber;
  SendToRequestCode({required this.phoneNumber});
}
