import 'dart:async';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_flutter/config/env.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes_impl.dart';
import 'package:portfolio_flutter/modules/core/data/hand_shake_repository.dart';
import 'package:portfolio_flutter/modules/core/data/hand_shake_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/network/config/network_config.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_hand_shake.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_user.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/sp/device_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/device_sp_impl.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/key_sp_impl.dart';
import 'package:portfolio_flutter/modules/core/data/sp/route_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/route_sp_impl.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization_impl.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes_impl.dart';
import 'package:portfolio_flutter/modules/core/security/keys.dart';
import 'package:portfolio_flutter/modules/core/security/keys_impl.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes.dart';
import 'package:portfolio_flutter/modules/core/utils/bytes_impl.dart';
import 'package:portfolio_flutter/modules/core/utils/strings.dart';
import 'package:portfolio_flutter/modules/core/utils/strings_impl.dart';
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
      ));

  @lazySingleton
  KeySP get keySP => KeySPImpl(
      sharedPreference: sharedPreferences,
      encryptionDecryptAES: encryptionDecryptAES,
      bytes: bytes);

  @lazySingleton
  DeviceSP get deviceSP => DeviceSPImpl(
      sharedPreference: sharedPreferences,
      encryptionDecryptAES: encryptionDecryptAES,
      bytes: bytes);

  @lazySingleton
  RouteSP get routeSP => RouteSPImpl(
      bytes: bytes,
      sharedPreferences: sharedPreferences,
      encryptionDecryptAES: encryptionDecryptAES);

  @lazySingleton
  RestUser get restUser => RestUser(
        NetworkConfig.config(
          keys: keys,
          bytes: bytes,
          keySP: keySP,
          deviceSP: deviceSP,
          encryptionDecryptAES: encryptionDecryptAES,
        ),
        baseUrl: (env?.baseUrl ?? ""),
      );

  @lazySingleton
  RestHandShake get restHandShake => RestHandShake(
        NetworkConfig.config(
          keys: keys,
          bytes: bytes,
          keySP: keySP,
          deviceSP: deviceSP,
          encryptionDecryptAES: encryptionDecryptAES,
        ),
        baseUrl: (env?.baseUrl ?? ""),
      );

  @lazySingleton
  HandShakeRepository get handShakeRepository => HandShakeRepositoryImpl(
        keySP: keySP,
        restHandShake: restHandShake,
        key: keys,
      );

  @lazySingleton
  RouteRepository get routeRepository => RouteRepositoryImpl(routeSP: routeSP);

  @lazySingleton
  UserRepository get userRepository => UserRepositoryImpl(restClient: restUser);

  @lazySingleton
  Bottomsheet get bottomSheet => BottomsheetImpl();

  @lazySingleton
  AppLocalization get appLocalization => AppLocalizationImpl();

  @lazySingleton
  Strings get strings => StringsImpl();

  @lazySingleton
  Loading get loading => LoadingImpl();
}
