import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_event.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_state.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_status.dart';
import 'package:portfolio_flutter/modules/uicountry/widget/listview_widget.dart';
import 'package:portfolio_flutter/modules/uicountry/widget/search_widget.dart';

class UiCountryPage extends StatefulWidget {
  const UiCountryPage({super.key});

  @override
  State<UiCountryPage> createState() => _UiCountryPageState();
}

class _UiCountryPageState extends State<UiCountryPage> {
  final UICountryBloc _uiCountryBloc = Modular.get();
  List<CountryModel> allCountries = [];

  @override
  void dispose() {
    super.dispose();
    _uiCountryBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Modular.to.pop();
        return false;
      },
      child: Scaffold(
        body: _buildBloc(),
      ),
    );
  }

  Widget _buildBloc() {
    _uiCountryBloc.add(GetListOfCountriesInCountry());
    return BlocBuilder<UICountryBloc, UiCountryBlocState>(
      bloc: _uiCountryBloc,
      builder: (context, state) {
        switch (state.status) {
          case UiCountryBlocStatus.loading:
            Loading loading = Modular.get();
            return Stack(
              children: [
                _body(),
                loading.showLoading(),
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
            ),
            Expanded(
              child: ListViewWidget(
                countries: allCountries,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
