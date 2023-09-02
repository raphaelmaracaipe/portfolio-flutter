import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_event.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_state.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_status.dart';
import 'package:portfolio_flutter/modules/uicountry/widget/listview_widget.dart';
import 'package:portfolio_flutter/modules/uicountry/widget/search_widget.dart';

@immutable
@RoutePage()
class UiCountryPage extends StatefulWidget {
  void Function(CountryModel)? onRateCountry;
  UiCountryPage({super.key, this.onRateCountry});

  @override
  State<UiCountryPage> createState() => _UiCountryPageState();
}

class _UiCountryPageState extends State<UiCountryPage> {
  final UICountryBloc _uiCountryBloc = GetIt.instance();
  final AppLocalization _appLocalizations = GetIt.instance();
  final Loading loading = GetIt.instance();
  List<CountryModel> allCountries = [];

  @override
  void dispose() {
    super.dispose();
    _uiCountryBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations.context = context;

    return Scaffold(
      body: _buildBloc(),
    );
  }

  Widget _buildBloc() {
    _uiCountryBloc.add(GetListOfCountriesInCountry());
    return BlocBuilder<UICountryBloc, UiCountryBlocState>(
      bloc: _uiCountryBloc,
      builder: (context, state) {
        switch (state.status) {
          case UiCountryBlocStatus.loading:
            return Stack(
              children: [
                _body(),
                loading.showLoading(_appLocalizations),
              ],
            );
          case UiCountryBlocStatus.loaded:
            allCountries = state.countries;
            return _body();
          default:
            return _body();
        }
      },
    );
  }

  SafeArea _body() {
    return SafeArea(
      key: const Key("uiCountryContainer"),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            SearchWidget(
              countries: allCountries,
              appLocalization: _appLocalizations,
              onRateCountry: widget.onRateCountry,
            ),
            Expanded(
              child: ListViewWidget(
                countries: allCountries,
                onRateCountry: widget.onRateCountry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
