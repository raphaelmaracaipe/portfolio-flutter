import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes.dart';
import 'package:portfolio_flutter/modules/core/data/assets/countries_codes_impl.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository.dart';
import 'package:portfolio_flutter/modules/core/data/countries_repository_impl.dart';
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
        Bind<CountriesRepository>(
          (i) => CountriesRepositoryImpl(countriesCode: i()),
        ),
        Bind<UiAuthBloc>(
          (i) => UiAuthBloc(countriesRepository: i()),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) {
          return UiAuthPage();
        }, transition: TransitionType.rightToLeft),
      ];
}
