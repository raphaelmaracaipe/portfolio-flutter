import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/app_colors.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_event.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_state.dart';
import 'package:portfolio_flutter/modules/uicountry/bloc/uicountry_bloc_status.dart';
import 'package:portfolio_flutter/modules/uicountry/widget/listview_widget.dart';
import 'package:portfolio_flutter/modules/uicountry/widget/loading_widget.dart';

class UiCountryPage extends StatefulWidget {
  const UiCountryPage({super.key});

  @override
  State<UiCountryPage> createState() => _UiCountryPageState();
}

class _UiCountryPageState extends State<UiCountryPage> {
  final TextEditingController _controller = TextEditingController();
  final UICountryBloc _uiCountryBloc = Modular.get();
  late AppLocalizations? _appLocalizations;

  List<CountryModel> selectedCountry = [];
  List<CountryModel> allCountries = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_searchListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_searchListener);
    _controller.dispose();
    super.dispose();
  }

  void _searchListener() {
    // String query = _controller.text;
    // if (query.isEmpty) {
    //   setState(() {
    //     selectedCountry = allCountries;
    //   });
    // } else {
    //   setState(() {
    //     selectedCountry = allCountries
    //         .where(
    //           (country) =>
    //               country.name.toLowerCase().contains(query.toLowerCase()),
    //         )
    //         .toList();
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context);
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
    _uiCountryBloc.add(GetListOfCountries());
    return BlocBuilder<UICountryBloc, UiCountryBlocState>(
      bloc: _uiCountryBloc,
      builder: (context, state) {
        switch (state.status) {
          case UiCountryBlocStatus.loading:
            return Stack(
              children: [
                _body(),
                const LoadingWidget(),
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
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            SearchAnchor.bar(
              barHintText: _appLocalizations?.countryTitleSearch,
              barBackgroundColor: const MaterialStatePropertyAll(
                AppColors.colorSearch,
              ),
              barElevation: const MaterialStatePropertyAll(0),
              suggestionsBuilder: (
                BuildContext context,
                SearchController controller,
              ) {
                return List<Widget>.generate(
                  allCountries.length,
                  (int index) {
                    return ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(allCountries[index].countryName),
                    );
                  },
                );
              },
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
