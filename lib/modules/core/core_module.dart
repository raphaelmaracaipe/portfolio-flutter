import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_flutter/config/env.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes_impl.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/network/config/network_config.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_client.dart';
import 'package:portfolio_flutter/modules/core/data/sp/route_sp.dart';
import 'package:portfolio_flutter/modules/core/data/sp/route_sp_impl.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization_impl.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes.dart';
import 'package:portfolio_flutter/modules/core/security/encryption_decrypt_aes_impl.dart';
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
        Bind.factory<RouteSP>(
          (i) => RouteSPImpl(
            bytes: i(),
            encryptionDecryptAES: i(),
            sharedPreferences: i(),
          ),
          export: true,
        ),
        Bind.factory<Bytes>(
          (i) => BytesImpl(),
          export: true,
        ),
        Bind.factory<EncryptionDecryptAES>(
          (i) => EncryptionDecryptAESImpl(
            encryptionChannel: const MethodChannel(
              'com.example.portfolio_flutter/encdesc',
            ),
          ),
          export: true,
        ),
        Bind.factory<Future<SharedPreferences>>(
          (i) => SharedPreferences.getInstance(),
          export: true,
        ),
        Bind.factory<Bottomsheet>(
          (i) => BottomsheetImpl(),
          export: true,
        ),
        Bind.factory<AppLocalization>(
          (i) => AppLocalizationImpl(),
          export: true,
        ),
        Bind.factory<Loading>(
          (i) => LoadingImpl(),
          export: true,
        ),
        Bind.factory<CountriesCode>(
          (i) => CountriesCodeImpl(assetBundle: rootBundle),
          export: true,
        ),
        Bind.factory<Strings>(
          (i) => StringsImpl(),
          export: true,
        ),
        Bind.factory<CountriesRepository>(
          (i) => CountriesRepositoryImpl(
            countriesCode: i(),
          ),
          export: true,
        ),
        Bind.factory<UserRepository>(
          (i) => UserRepositoryImpl(
            restClient: i(),
            sharedPreferences: i(),
          ),
          export: true,
        ),
        Bind.factory<RestClient>(
          (i) => RestClient(
            NetworkConfig.config(),
            baseUrl: (env?.baseUrl ?? ""),
          ),
          export: true,
        ),
        Bind.factory<Logger>(
          (i) => Logger(),
          export: true,
        ),
      ];
}
