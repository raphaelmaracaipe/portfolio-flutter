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

class UiAuthPage extends StatefulWidget {
  UiAuthPage({super.key});

  final UiAuthPageState _state = UiAuthPageState();

  set countries(CountryModel countrySelected) {
    _state._countrySelected = countrySelected;
  }

  @override
  State<UiAuthPage> createState() => _state;
}

class UiAuthPageState extends State<UiAuthPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _codeCountryController = TextEditingController();
  final UiAuthBloc _uiAuthBloc = Modular.get();

  late AnimationController _animationController;
  late Animation<double> _animation;
  late AppLocalizations? _appLocalizations;

  CountryModel? _countrySelected;
  bool _enableFieldPhone = false;
  bool _enableSearchInFieldCodCountry = true;
  List<CountryModel> countries = [];

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      key: const Key("uiPageContainer"),
      backgroundColor: AppColors.colorPrimary,
      body: _buildBloc(),
    );
  }

  Widget _buildBloc() {
    _uiAuthBloc.add(GetListOfCountriesInAuth());
    return BlocBuilder<UiAuthBloc, UiAuthBlocState>(
      bloc: _uiAuthBloc,
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
    _configAnimation();

    Modular.to.addListener(_listenerNavigation);
    _codeCountryController.addListener(_listenerCodeCountry);
  }

  void _configAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
    _codeCountryController.removeListener(_listenerCodeCountry);
    Modular.to.removeListener(_listenerNavigation);
  }

  void _listenerNavigation() {
    _enableSearchInFieldCodCountry = false;
    CountryModel? countrySelected = Modular.args.data;
    if (countrySelected != null) {
      setState(() {
        String codeCountry = countrySelected.codeCountry;
        _codeCountryController.text = codeCountry;
        if ((_countrySelected?.codeCountry ?? "") != codeCountry) {
          _phoneNumberController.text = '';
        }

        _countrySelected = countrySelected;
        _enableFieldPhone = true;
      });
    }
  }

  void _listenerCodeCountry() {
    if (!_enableSearchInFieldCodCountry) {
      _enableSearchInFieldCodCountry = true;
      return;
    }

    String textOfField = _codeCountryController.text;
    List<CountryModel> countriesFound = countries
        .where(
          (country) => country.codeCountry == textOfField,
        )
        .toList();

    if (countriesFound.isNotEmpty) {
      _countrySelected = countriesFound[0];
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
            (_appLocalizations?.authTitle ?? ""),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: AppFonts.openSans,
            ),
          ),
          Text(
            (_appLocalizations?.authTitle1 ?? ""),
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (
        BuildContext context,
        Widget? child,
      ) {
        return Transform.translate(
          offset: Offset(0, 100 * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: Container(
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
            ),
          ),
        );
      },
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
            controller: _codeCountryController,
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
              labelText: (_appLocalizations?.codCountry ?? ""),
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
            key: const Key("uiAuthFieldPhone"),
            enabled: _enableFieldPhone,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FormattedPhone(countryModel: _countrySelected),
            ],
            controller: _phoneNumberController,
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
              labelText: _appLocalizations?.fieldPhone ?? "",
            ),
          ),
        ),
      ),
    );
  }

  String _getCountrySelected() {
    if (_countrySelected == null) {
      return _appLocalizations?.country ?? "";
    }
    return _countrySelected?.countryName ?? "";
  }

  Container _showFlagCountry() {
    if (_countrySelected == null) {
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
    List<String> splitOnIson = _countrySelected?.codeIson.split(" / ") ?? [];
    if (splitOnIson.isNotEmpty) {
      return splitOnIson[0].toLowerCase();
    }
    return "";
  }
}
