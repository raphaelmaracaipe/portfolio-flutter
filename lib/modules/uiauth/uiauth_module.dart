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
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc.dart';
import 'package:portfolio_flutter/modules/uiauth/uiauth_pages.dart';

class UiAuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<Loading>(
          (i) => LoadingImpl(),
        ),
        Bind.factory<CountriesCode>(
          (i) => CountriesCodeImpl(assetBundle: rootBundle),
        ),
        Bind.factory<Strings>(
          (i) => StringsImpl(),
        ),
        Bind<CountriesRepository>(
          (i) => CountriesRepositoryImpl(
            countriesCode: i(),
          ),
        ),
        Bind<UserRepository>(
          (i) => UserRepositoryImpl(
            restClient: i(),
          ),
        ),
        Bind<RestClient>(
          (i) => RestClient(
            NetworkConfig.config(),
            baseUrl: (env?.baseUrl ?? ""),
          ),
        ),
        Bind<Logger>(
          (i) => Logger(),
        ),
        Bind<UiAuthBloc>(
          (i) => UiAuthBloc(
            countriesRepository: i(),
            logger: i(),
            userRepository: i(),
          ),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => UiAuthPage(),
          transition: TransitionType.rightToLeft,
        ),
      ];
}
