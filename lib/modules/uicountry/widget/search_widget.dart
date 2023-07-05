import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/app_colors.dart';
import 'package:portfolio_flutter/modules/app_fonts.dart';
import 'package:portfolio_flutter/modules/app_router.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchWidget extends StatefulWidget {
  final List<CountryModel> countries;

  const SearchWidget({required this.countries, super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late AppLocalizations? _appLocalizations;
  late SearchController _controller;
  bool _isDisposed = false;
  List<CountryModel> _selectedCountry = [];

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }

  void _searchListener() {
    if (!_isDisposed) {
      String query = _controller.text;
      if (query.isEmpty) {
        setState(() {
          _selectedCountry = widget.countries;
        });
      } else {
        setState(() {
          _selectedCountry = widget.countries
              .where(
                (country) => country.countryName.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context);
    _checkIfSelectedCountryIsEmptyAndTextSearchIsEmpty();

    return SearchAnchor.bar(
      barHintText: _appLocalizations?.countryTitleSearch,
      barBackgroundColor: const MaterialStatePropertyAll(
        AppColors.colorSearch,
      ),
      barElevation: const MaterialStatePropertyAll(0),
      suggestionsBuilder: (
        BuildContext context,
        SearchController controller,
      ) {
        if (!_isDisposed) {
          _controller = controller;
          _controller.addListener(_searchListener);
        }

        return List<Widget>.generate(
          _selectedCountry.length,
          (int index) => _buildItemListSearch(index),
        );
      },
    );
  }

  void _checkIfSelectedCountryIsEmptyAndTextSearchIsEmpty() {
    try {
      if (_selectedCountry.isEmpty && _controller.text.isEmpty) {
        _selectedCountry = widget.countries;
      }
    } catch (_) {
      _selectedCountry = widget.countries;
    }
  }

  Widget _buildItemListSearch(int index) {
    return GestureDetector(
      key: const Key("searchUiCountryItem"),
      onTap: () {
        Modular.to.pushReplacementNamed(
          AppRouter.uIAuth,
          arguments: _selectedCountry[index],
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
              right: 20,
              left: 20,
            ),
            child: _checkImageFlags(_selectedCountry[index]),
          ),
          Text(
            _selectedCountry[index].countryName,
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
