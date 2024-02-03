// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i13;
import 'package:flutter/services.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:portfolio_flutter/modules/core/core_module.dart' as _i37;
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes.dart'
    as _i8;
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart'
    as _i9;
import 'package:portfolio_flutter/modules/core/data/countries_repository_impl.dart'
    as _i10;
import 'package:portfolio_flutter/modules/core/data/device_repository.dart'
    as _i11;
import 'package:portfolio_flutter/modules/core/data/hand_shake_repository.dart'
    as _i16;
import 'package:portfolio_flutter/modules/core/data/key_repository.dart'
    as _i17;
import 'package:portfolio_flutter/modules/core/data/network/rest_hand_shake.dart'
    as _i23;
import 'package:portfolio_flutter/modules/core/data/network/rest_profile.dart'
    as _i24;
import 'package:portfolio_flutter/modules/core/data/network/rest_user.dart'
    as _i25;
import 'package:portfolio_flutter/modules/core/data/profile_repository.dart'
    as _i21;
import 'package:portfolio_flutter/modules/core/data/route_repository.dart'
    as _i26;
import 'package:portfolio_flutter/modules/core/data/sp/device_sp.dart' as _i12;
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart' as _i18;
import 'package:portfolio_flutter/modules/core/data/sp/route_sp.dart' as _i27;
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart' as _i30;
import 'package:portfolio_flutter/modules/core/data/user_repository.dart'
    as _i34;
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart'
    as _i3;
import 'package:portfolio_flutter/modules/core/regex/regex.dart' as _i22;
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart'
    as _i14;
import 'package:portfolio_flutter/modules/core/security/keys.dart' as _i19;
import 'package:portfolio_flutter/modules/core/utils/bytes.dart' as _i7;
import 'package:portfolio_flutter/modules/core/utils/files.dart' as _i15;
import 'package:portfolio_flutter/modules/core/utils/strings.dart' as _i29;
import 'package:portfolio_flutter/modules/core/widgets/bottomsheet/bottom_sheet.dart'
    as _i6;
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart'
    as _i20;
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc.dart' as _i35;
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc.dart'
    as _i31;
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc.dart'
    as _i32;
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc.dart'
    as _i33;
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc.dart'
    as _i36;
import 'package:portfolio_flutter/routers/app_router.dart' as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i28;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreModule = _$CoreModule();
    gh.lazySingleton<_i3.AppLocalization>(() => coreModule.appLocalization);
    gh.factory<_i4.AppRouter>(() => _i4.AppRouter());
    gh.lazySingleton<_i5.AssetBundle>(() => coreModule.assetBundle);
    gh.lazySingleton<_i6.Bottomsheet>(() => coreModule.bottomSheet);
    gh.lazySingleton<_i7.Bytes>(() => coreModule.bytes);
    gh.lazySingleton<_i8.CountriesCode>(() => coreModule.countriesCode);
    gh.factory<_i9.CountriesRepository>(() =>
        _i10.CountriesRepositoryImpl(countriesCode: gh<_i8.CountriesCode>()));
    gh.lazySingleton<_i11.DeviceRepository>(() => coreModule.deviceRepository);
    gh.lazySingleton<_i12.DeviceSP>(() => coreModule.deviceSP);
    gh.lazySingleton<_i13.Dio>(() => coreModule.dio);
    gh.lazySingleton<_i14.EncryptionDecryptAES>(
        () => coreModule.encryptionDecryptAES);
    gh.lazySingleton<_i15.Files>(() => coreModule.file);
    gh.lazySingleton<_i16.HandShakeRepository>(
        () => coreModule.handShakeRepository);
    gh.lazySingleton<_i17.KeyRepository>(() => coreModule.keyRepository);
    gh.lazySingleton<_i18.KeySP>(() => coreModule.keySP);
    gh.lazySingleton<_i19.Keys>(() => coreModule.keys);
    gh.lazySingleton<_i20.Loading>(() => coreModule.loading);
    gh.lazySingleton<_i21.ProfileRepository>(
        () => coreModule.profileRepository);
    gh.lazySingleton<_i22.Regex>(() => coreModule.regex);
    gh.lazySingleton<_i23.RestHandShake>(() => coreModule.restHandShake);
    gh.lazySingleton<_i24.RestProfile>(() => coreModule.restProfile);
    gh.lazySingleton<_i25.RestUser>(() => coreModule.restUser);
    gh.lazySingleton<_i26.RouteRepository>(() => coreModule.routeRepository);
    gh.lazySingleton<_i27.RouteSP>(() => coreModule.routeSP);
    gh.lazySingletonAsync<_i28.SharedPreferences>(
        () => coreModule.sharedPreferences);
    gh.lazySingleton<_i29.Strings>(() => coreModule.strings);
    gh.lazySingleton<_i30.TokenSP>(() => coreModule.tokenSP);
    gh.factory<_i31.UICountryBloc>(() =>
        _i31.UICountryBloc(countriesRepository: gh<_i9.CountriesRepository>()));
    gh.factory<_i32.UiProfileBloc>(() =>
        _i32.UiProfileBloc(profileRepository: gh<_i21.ProfileRepository>()));
    gh.factory<_i33.UiSplashBloc>(() => _i33.UiSplashBloc(
          key: gh<_i19.Keys>(),
          routeRepository: gh<_i26.RouteRepository>(),
          handShakeRepository: gh<_i16.HandShakeRepository>(),
        ));
    gh.lazySingleton<_i34.UserRepository>(() => coreModule.userRepository);
    gh.factory<_i35.UiAuthBloc>(() => _i35.UiAuthBloc(
          countriesRepository: gh<_i9.CountriesRepository>(),
          userRepository: gh<_i34.UserRepository>(),
          routeRepository: gh<_i26.RouteRepository>(),
        ));
    gh.factory<_i36.UiValidCodeBloc>(() => _i36.UiValidCodeBloc(
          userRepository: gh<_i34.UserRepository>(),
          routeRepository: gh<_i26.RouteRepository>(),
        ));
    return this;
  }
}

class _$CoreModule extends _i37.CoreModule {}
