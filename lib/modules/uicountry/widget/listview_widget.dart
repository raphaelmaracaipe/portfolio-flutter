import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/config/app_fonts.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';

// ignore: must_be_immutable
class ListViewWidget extends StatelessWidget {
  void Function(CountryModel)? onRateCountry;
  late List<CountryModel> _countries = [];
  final ColorsU _colorsU = GetIt.instance();

  ListViewWidget({
    required List<CountryModel> countries,
    super.key,
    this.onRateCountry,
  }) {
    _countries = countries;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key("listViewUiCountryContainer"),
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: _countries.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            key: Key("listViewUiCountryItem${_countries[index].codeCountry}"),
            onTap: () {
              onRateCountry!(_countries[index]);
              context.router.popForced();
            },
            child: Row(
              key: const Key("listViewUiCountryItemRow"),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                    right: 20,
                  ),
                  child: _checkImageFlags(_countries[index]),
                ),
                Text(
                  _countries[index].countryName,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: AppFonts.openSans,
                    color: _colorsU.checkColorsWhichIsDarkMode(
                      context: context,
                      light: AppColors.colorGray,
                      dark: AppColors.colorWhite,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
