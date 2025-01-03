import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/config/app_fonts.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';

@immutable
// ignore: must_be_immutable
class SearchWidget extends StatefulWidget {
  void Function(CountryModel)? onRateCountry;
  final List<CountryModel> countries;
  final AppLocalization appLocalization;

  SearchWidget({
    required this.appLocalization,
    required this.countries,
    super.key,
    this.onRateCountry,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  SearchController _searchController = SearchController();
  bool _isDisposed = false;
  List<CountryModel> _selectedCountry = [];

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchListener);
  }

  @override
  Widget build(BuildContext context) {
    widget.appLocalization.context = context;
    _checkIfSelectedCountryIsEmptyAndTextSearchIsEmpty();

    return SearchAnchor.bar(
      viewBackgroundColor: Colors.white,
      barHintText:
          widget.appLocalization.localization?.countryTitleSearch ?? "",
      barBackgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.focused)) {
            return AppColors.colorSearch.withOpacity(0.8); // Cor quando focado
          }
          return AppColors.colorSearch; // Cor padrão
        },
      ),
      barElevation: WidgetStateProperty.resolveWith<double>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.hovered)) {
            return 4.0; // Elevação maior ao passar o mouse
          }
          return 0.0; // Elevação padrão
        },
      ),
      suggestionsBuilder: (
        BuildContext context,
        SearchController controller,
      ) {
        if (!_isDisposed) {
          _searchController = controller;
          _searchController.addListener(_searchListener);
        }

        return List<Widget>.generate(
          _selectedCountry.length,
          (int index) => _buildItemListSearch(index),
        );
      },
    );
  }

  void _searchListener() {
    if (!_isDisposed) {
      String query = _searchController.text;
      setState(() {
        if (query.isEmpty) {
          _selectedCountry = widget.countries;
        } else {
          _selectedCountry = widget.countries
              .where(
                (country) => country.countryName.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList();
        }
      });
    }
  }

  void _checkIfSelectedCountryIsEmptyAndTextSearchIsEmpty() {
    try {
      if (_selectedCountry.isEmpty && _searchController.text.isEmpty) {
        _selectedCountry = widget.countries;
      }
    } on Exception catch (_) {
      _selectedCountry = widget.countries;
    }
  }

  Widget _buildItemListSearch(int index) {
    CountryModel country = _selectedCountry[index];
    return GestureDetector(
      onTap: () {
        widget.onRateCountry!(country);
        context.router.popUntilRoot();
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
              right: 20,
              left: 20,
            ),
            child: _checkImageFlags(country),
          ),
          Text(
            key: Key("searchUiCountryItem${country.codeCountry}"),
            country.countryName,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: AppFonts.openSans,
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkImageFlags(CountryModel country) {
    final String nameFlag = _getNameFlag(country).toLowerCase();
    final String location = "assets/images/flags/$nameFlag.png";
    return Image.asset(
      location,
      width: 25,
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox(
          width: 50,
          height: 40,
        );
      },
    );
  }

  String _getNameFlag(CountryModel country) {
    List<String> splitOnIson = country.codeIson.split(" / ");
    if (splitOnIson.isNotEmpty) {
      return splitOnIson[0];
    }
    return "";
  }
}
