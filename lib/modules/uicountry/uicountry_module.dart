import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes_impl.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository_impl.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc.dart';
import 'package:portfolio_flutter/modules/uicountry/uicountry_page.dart';

class UiCountryModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory<CountriesCode>(
          (i) => CountriesCodeImpl(),
        ),
        Bind.factory<CountriesRepository>(
          (i) => CountriesRepositoryImpl(
            countriesCode: i(),
          ),
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
          child: (context, args) => const UiCountryPage(),
          transition: TransitionType.rightToLeft,
        )
      ];
}
