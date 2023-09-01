import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_flutter/config/app_route1.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_event.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_state.dart';

@Injectable()
class UiAuthBloc extends Bloc<UiAuthBlocEvent, UiAuthBlocState> {
  late final CountriesRepository _countriesRepository;
  late final UserRepository _userRepository;
  late final RouteRepository _routeRepository;

  UiAuthBloc({
    required CountriesRepository countriesRepository,
    required UserRepository userRepository,
    required RouteRepository routeRepository,
  }) : super(UiAuthBlocUnknown()) {
    _userRepository = userRepository;
    _countriesRepository = countriesRepository;
    _routeRepository = routeRepository;

    on<GetListOfCountriesInAuth>(_onGetListOfCountries);
    on<SendToRequestCode>(_onSendToRequestCode);
  }

  void _onGetListOfCountries(
    GetListOfCountriesInAuth event,
    Emitter<UiAuthBlocState> emitter,
  ) async {
    emitter(UiAuthBlocLoading());
    try {
      List<CountryModel> countries = await _countriesRepository.readJSON();
      emitter(UiAuthBlocLoaded(countries));
    } on Exception catch (_) {
      emitter(UiAuthBlocError());
    }
  }

  void _onSendToRequestCode(
    SendToRequestCode event,
    Emitter<UiAuthBlocState> emitter,
  ) async {
    emitter(UiAuthBlocLoading());
    try {
      final RequestUserCode requestUserCode = RequestUserCode(
        phone: event.phoneNumber,
      );

      await _userRepository.requestCode(requestUserCode);
      await _routeRepository.save(AppRoute1.uIValidCode);

      emitter(UiAuthBlocResponseSendCode(isSuccess: true));
    } on Exception catch (_) {
      emitter(UiAuthBlocResponseSendCode(isSuccess: false));
    }
  }
}
