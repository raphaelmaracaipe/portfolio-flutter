import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_client.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_event.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_state.dart';

class UiAuthBloc extends Bloc<UiAuthBlocEvent, UiAuthBlocState> {
  late final CountriesRepository _countriesRepository;
  late final RestClient _restClient;
  late final Logger _logger;

  UiAuthBloc({
    required CountriesRepository countriesRepository,
    required RestClient restClient,
    required Logger logger,
  }) : super(UiAuthBlocUnknown()) {
    _countriesRepository = countriesRepository;
    _restClient = restClient;
    _logger = logger;

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
    } catch (_) {
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
      await _restClient.requestCode(requestUserCode);
      emitter(UiAuthBlocResponseSendCode(isSuccess: true));
    } catch (e) {
      _logger.e(e);
      emitter(UiAuthBlocResponseSendCode(isSuccess: false));
    }
  }
}
