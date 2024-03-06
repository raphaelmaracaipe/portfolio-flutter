import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/config/app_fonts.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/phone/phone_formatted.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/core/utils/strings.dart';
import 'package:portfolio_flutter/modules/core/widgets/loading/loading.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_event.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_state.dart';
import 'package:portfolio_flutter/modules/uiauth/bloc/uiauth_bloc_status.dart';
import 'package:portfolio_flutter/routers/app_router.gr.dart';

@RoutePage()
class UiAuthPage extends StatefulWidget {
  const UiAuthPage({super.key});

  @override
  State<UiAuthPage> createState() => UiAuthPageState();
}

class UiAuthPageState extends State<UiAuthPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _codeCountryController = TextEditingController();
  final ColorsU _colorsU = GetIt.instance();
  final UiAuthBloc _uiAuthBloc = GetIt.instance();
  final Strings _strings = GetIt.instance();
  final AppLocalization _appLocalizations = GetIt.instance();
  final Loading loading = GetIt.instance();

  late AnimationController _animationController;
  late Animation<double> _animation;

  CountryModel? _countrySelected;
  bool _enableFieldPhone = false;
  bool _enableSearchInFieldCodCountry = true;
  List<CountryModel> _countries = [];

  @override
  Widget build(BuildContext context) {
    _appLocalizations.context = context;

    return Scaffold(
      key: const Key("uiPageContainer"),
      backgroundColor: _colorsU.checkColorsWhichIsDarkMode(
        context: context,
        light: AppColors.colorPrimary,
        dark: AppColors.colorBlack,
      ),
      body: Stack(children: [
        _body(),
        _buildBloc(),
      ]),
    );
  }

  Widget _buildBloc() {
    _uiAuthBloc.add(GetListOfCountriesInAuth());
    return BlocBuilder<UiAuthBloc, UiAuthBlocState>(
      bloc: _uiAuthBloc,
      builder: (context, state) {
        switch (state.status) {
          case UiAuthBlocStatus.loading:
            return loading.showLoading(_appLocalizations, _colorsU);
          case UiAuthBlocStatus.loaded:
            _countries = state.countries;
            break;
          case UiAuthBlocStatus.codeRequest:
            if (!state.isSuccess) {
              Fluttertoast.showToast(
                msg: (_appLocalizations.localization?.errorGeneral ?? ""),
                toastLength: Toast.LENGTH_SHORT,
              );
            } else {
              context.router.removeLast();
              context.router.push(const UiValidCodeRoutes());
            }
            break;
        }
        return Container();
      },
    );
  }

  Column _body() {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _heroOfImgApp(),
            ],
          ),
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (
            BuildContext context,
            Widget? child,
          ) {
            return Transform.translate(
              offset: Offset(0, 100 * (1 - _animation.value)),
              child: _buildFormToAuth(),
            );
          },
        ),
      ],
    );
  }

  Opacity _buildFormToAuth() {
    return Opacity(
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
            _buildSelectionCountry(),
            _buildSelectionCodCountryAndNumberPhone(),
            _buildSelectionButtonSend(),
            _buildSelectionCopyright()
          ],
        ),
      ),
    );
  }

  Row _buildSelectionCopyright() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          child: Text(
            "Raphael Maracaipe",
            style: TextStyle(
              fontFamily: AppFonts.openSans,
              fontWeight: FontWeight.bold,
              color: _colorsU.checkColorsWhichIsDarkMode(
                context: context,
                light: AppColors.colorPrimary,
                dark: AppColors.colorBlack,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildSelectionButtonSend() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: sendToServer,
              style: ElevatedButton.styleFrom(
                backgroundColor: _colorsU.checkColorsWhichIsDarkMode(
                  context: context,
                  light: AppColors.colorPrimary,
                  dark: AppColors.colorBlack,
                ),
              ),
              key: const Key("uiAuthButtonSend"),
              child: Text(
                (_appLocalizations.localization?.btnSignin ?? ""),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildSelectionCodCountryAndNumberPhone() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            child: SizedBox(
              width: 100,
              child: TextField(
                key: const Key("uiAuthFieldCountryCode"),
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
                  labelText: (_appLocalizations.localization?.codCountry ?? ""),
                ),
              ),
            ),
          ),
        ),
        Expanded(
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
                  labelText: _appLocalizations.localization?.fieldPhone ?? "",
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildSelectionCountry() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.colorGray,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: GestureDetector(
              key: const Key("uiAuthCountry"),
              onTap: () {
                context.router.push(UiCountryRoute(onRateCountry: (country) {
                  setState(() {
                    _phoneNumberController.text = "";
                    _codeCountryController.text = "";

                    _countrySelected = country;
                  });
                }));
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
        ),
      ],
    );
  }

  Hero _heroOfImgApp() {
    return Hero(
      tag: 'img_app',
      child: SvgPicture.asset(
        "assets/images/icon_app.svg",
        color: Colors.white,
        width: 150,
      ),
    );
  }

  void sendToServer() {
    FocusManager.instance.primaryFocus?.unfocus();

    String codeCountry = _codeCountryController.text;
    String phoneNumber = _phoneNumberController.text;

    String concatNumbers = "+$codeCountry${_strings.onlyNumber(
      phoneNumber,
    )}";

    _uiAuthBloc.add(SendToRequestCode(phoneNumber: concatNumbers));
  }

  @override
  void initState() {
    super.initState();
    _configAnimation();

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
  }

  void _listenerCodeCountry() {
    if (!_enableSearchInFieldCodCountry) {
      _enableSearchInFieldCodCountry = true;
      return;
    }

    String textOfField = _codeCountryController.text;
    List<CountryModel> countriesFound = _countries
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

  String _getCountrySelected() {
    if (_countrySelected == null) {
      return _appLocalizations.localization?.country ?? "";
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
