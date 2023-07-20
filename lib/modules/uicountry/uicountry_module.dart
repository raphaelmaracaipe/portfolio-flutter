import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/config/env.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes_impl.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/network/config/network_config.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_client.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading_impl.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc.dart';
import 'package:portfolio_flutter/modules/uicountry/uicountry_page.dart';

class UiCountryModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory<Loading>(
          (i) => LoadingImpl(),
        ),
        Bind.factory<CountriesCode>(
          (i) => CountriesCodeImpl(assetBundle: rootBundle),
        ),
        Bind<RestClient>(
          (i) => RestClient(
            NetworkConfig.config(),
            baseUrl: (env?.baseUrl ?? ""),
          ),
        ),
        Bind.factory<CountriesRepository>(
          (i) => CountriesRepositoryImpl(countriesCode: i()),
        ),
        Bind.factory<UICountryBloc>(
          (i) => UICountryBloc(
            countriesRepository: i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) {
            return const UiCountryPage();
          },
          transition: TransitionType.rightToLeft,
        )
      ];
}
