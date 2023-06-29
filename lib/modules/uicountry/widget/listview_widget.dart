import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio_flutter/modules/app_fonts.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';

// ignore: must_be_immutable
class ListViewWidget extends StatelessWidget {
  late List<CountryModel> _countries = [];

  ListViewWidget({
    required List<CountryModel> countries,
    super.key,
  }) {
    _countries = countries;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _countries.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Modular.to.pop("test");
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
                  ),
                  child: _checkImageFlags(_countries[index]),
                ),
                Text(
                  _countries[index].countryName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: AppFonts.OpenSans,
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
      width: 50,
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
