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
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/utils/strings.dart';
import 'package:portfolio_flutter/modules/core/utils/strings_impl.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading_impl.dart';

class CoreModule extends Module {
  @override
  List<Bind<Object>> get binds => [
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
        Bind<CountriesRepository>(
          (i) => CountriesRepositoryImpl(
            countriesCode: i(),
          ),
          export: true,
        ),
        Bind<UserRepository>(
          (i) => UserRepositoryImpl(
            restClient: i(),
          ),
          export: true,
        ),
        Bind<RestClient>(
          (i) => RestClient(
            NetworkConfig.config(),
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
