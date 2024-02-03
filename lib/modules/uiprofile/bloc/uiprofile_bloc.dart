import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_flutter/modules/core/data/profile_repository.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc_event.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc_state.dart';

@Injectable()
class UiProfileBloc extends Bloc<UiProfileBlocEvent, UiProfileBlocState> {
  final ProfileRepository profileRepository;

  UiProfileBloc({
    required this.profileRepository,
  }) : super(const UiProfileBlocStateUknown()) {
    on<SendProfile>(_sendProfile);
  }

  Future<void> _sendProfile(
    SendProfile event,
    Emitter<UiProfileBlocState> emmitter,
  ) async {
    try {
      await profileRepository.sendProfile(event.profile);
      emmitter(const UiProfileBlocUpdateSucces());
    } on Exception catch (e) {
      print(e);
    }
  }
}
