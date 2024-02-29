import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_flutter/modules/core/data/profile_repository.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc_event.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc_state.dart';
import 'package:portfolio_flutter/routers/app_router.gr.dart';

@Injectable()
class UiProfileBloc extends Bloc<UiProfileBlocEvent, UiProfileBlocState> {
  final ProfileRepository profileRepository;
  final RouteRepository routeRepository;

  UiProfileBloc({
    required this.profileRepository,
    required this.routeRepository,
  }) : super(const UiProfileBlocStateUknown()) {
    on<SendProfile>(_sendProfile);
  }

  Future<void> _sendProfile(
    SendProfile event,
    Emitter<UiProfileBlocState> emmitter,
  ) async {
    emmitter(const UiProfileBlocStateLoading());
    try {
      await profileRepository.sendProfile(event.profile);
      await routeRepository.save(UiContactRoutes.name);

      emmitter(const UiProfileBlocStateUpdateSuccess());
    } on Exception catch (_) {
      emmitter(const UiProfileBlocStateError());
    }
  }
}
