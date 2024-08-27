import 'package:portfolio_flutter/modules/core/data/network/request/request_profile.dart';

sealed class UiProfileBlocEvent {
  const UiProfileBlocEvent();
}

final class SendProfile extends UiProfileBlocEvent {
  final RequestProfile profile;
  SendProfile({required this.profile});
}

final class GetProfile extends UiProfileBlocEvent {
  GetProfile();
}
