import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio_flutter/modules/app_colors.dart';
import 'package:portfolio_flutter/modules/app_fonts.dart';
import 'package:portfolio_flutter/modules/app_router.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/phone/phone_formatted.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_event.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_state.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_status.dart';

// ignore: must_be_immutable
class UiAuthPage extends StatefulWidget {
  CountryModel? countrySelected;
  late AppLocalizations? _appLocalizations;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _codeCountryController = TextEditingController();
  final UiAuthBloc _uiAuthBloc = Modular.get();

  UiAuthPage({super.key});

  @override
  State<UiAuthPage> createState() => _UiAuthPageState();
}

class _UiAuthPageState extends State<UiAuthPage> {
  bool _enableFieldPhone = false;
  bool _enableSearchInFieldCodCountry = true;
  List<CountryModel> countries = [];

  @override
  Widget build(BuildContext context) {
    widget._appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      key: const Key("uiPageContainer"),
      backgroundColor: AppColors.colorPrimary,
      body: _buildBloc(),
    );
  }

  Widget _buildBloc() {
    widget._uiAuthBloc.add(GetListOfCountriesInAuth());
    return BlocBuilder<UiAuthBloc, UiAuthBlocState>(
      bloc: widget._uiAuthBloc,
      builder: (context, state) {
        switch (state.status) {
          case UiAuthBlocStatus.loading:
            Loading loading = Modular.get();
            return Stack(
              children: [
                _body(),
                loading.showLoading(),
              ],
            );
          case UiAuthBlocStatus.loaded:
            countries = state.countries;
            return _body();
          default:
            return _body();
        }
      },
    );
  }

  Column _body() {
    return Column(
      children: [
        _containerTop(),
        _containerOfInputs(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    Modular.to.addListener(_listenerNavigation);
    widget._codeCountryController.addListener(_listenerCodeCountry);
  }

  @override
  void dispose() {
    super.dispose();

    widget._codeCountryController.removeListener(_listenerCodeCountry);
    Modular.to.removeListener(_listenerNavigation);
  }

  void _listenerNavigation() {
    _enableSearchInFieldCodCountry = false;
    CountryModel? countrySelected = Modular.args.data;
    if (countrySelected != null) {
      setState(() {
        widget._codeCountryController.text = countrySelected.codeCountry;

        if ((countrySelected.codeCountry) != countrySelected.codeCountry) {
          widget._phoneNumberController.text = '';
        }

        widget.countrySelected = countrySelected;
      });
    }
  }

  void _listenerCodeCountry() {
    if (!_enableSearchInFieldCodCountry) {
      _enableSearchInFieldCodCountry = true;
      return;
    }

    String textOfField = widget._codeCountryController.text;
    List<CountryModel> countriesFound = countries
        .where(
          (country) => country.codeCountry == textOfField,
        )
        .toList();

    if (countriesFound.isNotEmpty) {
      widget.countrySelected = countriesFound[0];
    }

    setState(() {
      if (textOfField.isNotEmpty) {
        _enableFieldPhone = true;
      } else {
        _enableFieldPhone = false;
      }
    });
  }

  Expanded _containerTop() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/icon_app.svg",
            color: Colors.white,
            width: 150,
          ),
          Text(
            (widget._appLocalizations?.authTitle ?? ""),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: AppFonts.openSans,
            ),
          ),
          Text(
            (widget._appLocalizations?.authTitle1 ?? ""),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: AppFonts.openSans,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _containerOfInputs() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              _buttonCountry(),
            ],
          ),
          Row(
            children: [
              _inputCodeCountry(),
              _inputPhone(),
            ],
          ),
          Row(
            children: [
              _buttonEnter(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                child: const Text(
                  "Raphael Maracaipe",
                  style: TextStyle(
                    fontFamily: AppFonts.openSans,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorPrimary,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buttonCountry() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.colorGray,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: GestureDetector(
          key: const Key("uiAuthCountry"),
          onTap: () {
            Modular.to.pushNamed(AppRouter.uICountry);
          },
          child: Row(
            children: [
              _showFlagCountry(),
              Expanded(
                child: Text(
                  _getCountrySelected(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.colorGray,
                    fontFamily: AppFonts.openSans,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.colorGray,
              )
            ],
          ),
        ),
      ),
    );
  }

  String _getCountrySelected() {
    if (widget.countrySelected == null) {
      return widget._appLocalizations?.country ?? "";
    }
    return widget.countrySelected?.countryName ?? "";
  }

  Container _showFlagCountry() {
    if (widget.countrySelected == null) {
      return Container();
    }

    final String location = "assets/images/flags/${_getNameFlag()}.png";
    return Container(
      width: 25,
      margin: const EdgeInsets.only(right: 10),
      child: Image.asset(
        key: const Key("uiAuthCountryImageFlag"),
        location,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            key: const Key("uiAuthCountryFailLoadingImageFlag"),
          );
        },
      ),
    );
  }

  String _getNameFlag() {
    List<String> splitOnIson = widget.countrySelected?.codeIson.split(" / ") ?? [];
    if (splitOnIson.isNotEmpty) {
      return splitOnIson[0].toLowerCase();
    }
    return "";
  }

  Expanded _buttonEnter() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.colorPrimary,
          ),
          child: const Text(
            "ENTRAR",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Expanded _inputCodeCountry() {
    return Expanded(
      flex: 3,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: SizedBox(
          width: 100,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: widget._codeCountryController,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.colorGray,
                ),
              ),
              border: const OutlineInputBorder(),
              focusColor: AppColors.colorGray,
              labelStyle: const TextStyle(
                color: AppColors.colorGray,
              ),
              labelText: (widget._appLocalizations?.codCountry ?? ""),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _inputPhone() {
    return Expanded(
      flex: 7,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: SizedBox(
          width: 100,
          child: TextField(
            enabled: _enableFieldPhone,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FormattedPhone(countryModel: widget.countrySelected),
            ],
            controller: widget._phoneNumberController,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.colorGray,
                ),
              ),
              border: const OutlineInputBorder(),
              focusColor: AppColors.colorGray,
              labelStyle: const TextStyle(
                color: AppColors.colorGray,
              ),
              labelText: widget._appLocalizations?.fieldPhone ?? "",
            ),
          ),
        ),
      ),
    );
  }
}
