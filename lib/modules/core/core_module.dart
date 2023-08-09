import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/config/env.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes_impl.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository_impl.dart';
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

class CoreModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind<Keys>(
          (i) => KeysImpl(),
          export: true,
        ),
        Bind<RouteSP>(
          (i) => RouteSPImpl(
            bytes: i(),
            encryptionDecryptAES: i(),
            sharedPreferences: i(),
          ),
          export: true,
        ),
        Bind<DeviceSP>(
          (i) => DeviceSPImpl(
            sharedPreference: i(),
            encryptionDecryptAES: i(),
            bytes: i(),
          ),
          export: true,
        ),
        Bind<KeySP>(
          (i) => KeySPImpl(
            sharedPreference: i(),
            encryptionDecryptAES: i(),
            bytes: i(),
          ),
          export: true,
        ),
        Bind<Bytes>(
          (i) => BytesImpl(),
          export: true,
        ),
        Bind<EncryptionDecryptAES>(
          (i) => EncryptionDecryptAESImpl(
            encryptionChannel: const MethodChannel(
              'com.example.portfolio_flutter/encdesc',
            ),
          ),
          export: true,
        ),
        Bind<Future<SharedPreferences>>(
          (i) => SharedPreferences.getInstance(),
          export: true,
        ),
        Bind<Bottomsheet>(
          (i) => BottomsheetImpl(),
          export: true,
        ),
        Bind<AppLocalization>(
          (i) => AppLocalizationImpl(),
          export: true,
        ),
        Bind<Loading>(
          (i) => LoadingImpl(),
          export: true,
        ),
        Bind<CountriesCode>(
          (i) => CountriesCodeImpl(
            assetBundle: rootBundle,
          ),
          export: true,
        ),
        Bind<Strings>(
          (i) => StringsImpl(),
          export: true,
        ),
        Bind<CountriesRepository>(
          (i) => CountriesRepositoryImpl(
            countriesCode: i(),
          ),
          export: true,
        ),
        Bind<HandShakeRepository>(
          (i) => HandShakeRepositoryImpl(
            key: i(),
            keySP: i(),
            restHandShake: i(),
          ),
          export: true,
        ),
        Bind<UserRepository>(
          (i) => UserRepositoryImpl(
            restClient: i(),
          ),
          export: true,
        ),
        Bind<RouteRepository>(
          (i) => RouteRepositoryImpl(
            routeSP: i(),
          ),
          export: true,
        ),
        Bind<RestUser>(
          (i) => RestUser(
            NetworkConfig.config(
              keys: i(),
              bytes: i(),
              keySP: i(),
              deviceSP: i(),
              encryptionDecryptAES: i(),
            ),
            baseUrl: (env?.baseUrl ?? ""),
          ),
          export: true,
        ),
        Bind<RestHandShake>(
          (i) => RestHandShake(
            NetworkConfig.config(
              keys: i(),
              bytes: i(),
              keySP: i(),
              deviceSP: i(),
              encryptionDecryptAES: i(),
            ),
            baseUrl: (env?.baseUrl ?? ""),
          ),
          export: true,
        ),
        Bind<Logger>(
          (i) => Logger(),
          export: true,
        ),
      ];
}
