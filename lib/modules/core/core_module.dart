import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_flutter/config/env.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes_impl.dart';
import 'package:portfolio_flutter/modules/core/data/device_repository.dart';
import 'package:portfolio_flutter/modules/core/data/device_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/hand_shake_repository.dart';
import 'package:portfolio_flutter/modules/core/data/hand_shake_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/key_repository.dart';
import 'package:portfolio_flutter/modules/core/data/key_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/network/config/network_config.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_contact.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_hand_shake.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_profile.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_token.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_user.dart';
import 'package:portfolio_flutter/modules/core/data/profile_repository.dart';
import 'package:portfolio_flutter/modules/core/data/profile_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/sp/device_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/device_sp_impl.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp_impl.dart';
import 'package:portfolio_flutter/modules/core/data/sp/route_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/route_sp_impl.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp_impl.dart';
import 'package:portfolio_flutter/modules/core/data/sp/user_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/user_sp_impl.dart';
import 'package:portfolio_flutter/modules/core/data/token_interceptor_repository.dart';
import 'package:portfolio_flutter/modules/core/data/token_interceptor_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization_impl.dart';
import 'package:portfolio_flutter/modules/core/regex/regex.dart';
import 'package:portfolio_flutter/modules/core/regex/regex_impl.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes_impl.dart';
import 'package:portfolio_flutter/modules/core/security/keys.dart';
import 'package:portfolio_flutter/modules/core/security/keys_impl.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes_impl.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_impl.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/core/utils/files.dart';
import 'package:portfolio_flutter/modules/core/utils/files_impl.dart';
import 'package:portfolio_flutter/modules/core/utils/images.dart';
import 'package:portfolio_flutter/modules/core/utils/images_impl.dart';
import 'package:portfolio_flutter/modules/core/utils/strings.dart';
import 'package:portfolio_flutter/modules/core/utils/strings_impl.dart';
import 'package:portfolio_flutter/modules/core/utils/images.dart';
import 'package:portfolio_flutter/modules/core/utils/images_impl.dart';
import 'package:portfolio_flutter/modules/core/widgets/bottomsheet/bottom_sheet.dart';
import 'package:portfolio_flutter/modules/core/widgets/bottomsheet/bottom_sheet_impl.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class CoreModule {
  @lazySingleton
  AssetBundle get assetBundle => rootBundle;

  @lazySingleton
  CountriesCode get countriesCode => CountriesCodeImpl(
        assetBundle: assetBundle,
      );

  @lazySingleton
  Future<SharedPreferences> get sharedPreferences async =>
      await SharedPreferences.getInstance();

  @lazySingleton
  Bytes get bytes => BytesImpl();

  @lazySingleton
  Keys get keys => KeysImpl();

  @lazySingleton
  EncryptionDecryptAES get encryptionDecryptAES => EncryptionDecryptAESImpl(
        encryptionChannel: const MethodChannel(
          'br.com.raphaelmaracaipe.portfolio_flutter/encdesc',
        ),
      );

  @lazySingleton
  Regex get regex => RegexImpl(
          regexChannel: const MethodChannel(
        'br.com.raphaelmaracaipe.portfolio_flutter/regex',
      ));

  @lazySingleton
  KeySP get keySP => KeySPImpl(
        sharedPreference: sharedPreferences,
        encryptionDecryptAES: encryptionDecryptAES,
        bytes: bytes,
      );

  @lazySingleton
  DeviceSP get deviceSP => DeviceSPImpl(
        sharedPreference: sharedPreferences,
        encryptionDecryptAES: encryptionDecryptAES,
        bytes: bytes,
      );

  @lazySingleton
  RouteSP get routeSP => RouteSPImpl(
        bytes: bytes,
        sharedPreferences: sharedPreferences,
        encryptionDecryptAES: encryptionDecryptAES,
      );

  @lazySingleton
  TokenSP get tokenSP => TokenSPImpl(
        bytes: bytes,
        sharedPreferences: sharedPreferences,
        encryptionDecryptAES: encryptionDecryptAES,
      );

  @lazySingleton
  UserSP get userSP => UserSPImpl(
        bytes: bytes,
        sharedPreferences: sharedPreferences,
        encryptionDecryptAES: encryptionDecryptAES,
      );

  @lazySingleton
  Dio get dio => NetworkConfig.config(
        keys: keys,
        bytes: bytes,
        keyRepository: keyRepository,
        deviceRepository: deviceRepository,
        tokenInterceptorRepository: tokenInterceptorRepository,
        encryptionDecryptAES: encryptionDecryptAES,
        deviceSP: deviceSP,
        keySP: keySP,
        routeSP: routeSP,
        userSP: userSP,
        tokenSP: tokenSP,
      );

  @lazySingleton
  RestContact get restContact => RestContact(
        dio,
        baseUrl: (env?.baseUrl ?? ""),
      );

  @lazySingleton
  RestUser get restUser => RestUser(
        dio,
        baseUrl: (env?.baseUrl ?? ""),
      );

  @lazySingleton
  RestHandShake get restHandShake => RestHandShake(
        dio,
        baseUrl: (env?.baseUrl ?? ""),
      );

  @lazySingleton
  RestProfile get restProfile => RestProfile(
        dio,
        baseUrl: (env?.baseUrl ?? ""),
      );

  @lazySingleton
  RestToken get restTokenInterceptor => RestToken(
        NetworkConfig.config(
          keys: keys,
          bytes: bytes,
          keyRepository: keyRepository,
          deviceRepository: deviceRepository,
          encryptionDecryptAES: encryptionDecryptAES,
          tokenSP: tokenSP,
          deviceSP: deviceSP,
          keySP: keySP,
          routeSP: routeSP,
          userSP: userSP,
        ),
        baseUrl: (env?.baseUrl ?? ""),
      );

  @lazySingleton
  HandShakeRepository get handShakeRepository => HandShakeRepositoryImpl(
        keySP: keySP,
        restHandShake: restHandShake,
        regex: regex,
      );

  @lazySingleton
  RouteRepository get routeRepository => RouteRepositoryImpl(
        routeSP: routeSP,
      );

  @lazySingleton
  UserRepository get userRepository => UserRepositoryImpl(
      restClient: restUser, tokenSP: tokenSP, userSP: userSP);

  @lazySingleton
  KeyRepository get keyRepository => KeyRepositoryImpl(
        sp: keySP,
        regex: regex,
      );

  @lazySingleton
  DeviceRepository get deviceRepository => DeviceRepositoryImpl(
        deviceSP: deviceSP,
        regex: regex,
      );

  @lazySingleton
  ProfileRepository get profileRepository => ProfileRepositoryImpl(
        restProfile: restProfile,
      );

  @lazySingleton
  TokenInterceptorRepository get tokenInterceptorRepository =>
      TokenInterceptorRepositoryImpl(
        restToken: restTokenInterceptor,
        tokenSP: tokenSP,
      );

  @lazySingleton
  Bottomsheet get bottomSheet => BottomsheetImpl();

  @lazySingleton
  AppLocalization get appLocalization => AppLocalizationImpl();

  @lazySingleton
  ColorsU get colors => ColorsUImpl();

  @lazySingleton
  Strings get strings => StringsImpl();

  @lazySingleton
  Images get images => ImagesImpl();

  @lazySingleton
  Loading get loading => LoadingImpl();

  @lazySingleton
  Files get file => FilesImpl();
}
