import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/config/app_fonts.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';

@RoutePage()
class UiProfilePage extends StatefulWidget {
  const UiProfilePage({super.key});

  @override
  State<UiProfilePage> createState() => _UiProfilePageState();
}

class _UiProfilePageState extends State<UiProfilePage> {
  final AppLocalization _appLocalizations = GetIt.instance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        title: Text(
          _appLocalizations.localization?.profileTitle ?? "",
          style: const TextStyle(
            color: AppColors.colorWhite,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            _widgetOfImage(),
            _widgetOfInputName(),
            _widgetOfButton(),
            _widgetOfNameDev()
          ],
        ),
      ),
    );
  }

  Widget _widgetOfNameDev() => Container(
        margin: const EdgeInsets.only(
          bottom: 30,
          top: 30,
        ),
        child: const Text(
          "Raphael Maracaipe",
          style: TextStyle(
            color: AppColors.colorGray,
            fontFamily: AppFonts.openSans,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget _widgetOfButton() => TextButton(
        onPressed: _onPressedButtonContinue,
        child: Text(_appLocalizations.localization?.generalContinue ?? ""),
      );

  Widget _widgetOfInputName() => Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 30, left: 40, right: 40),
          alignment: Alignment.center,
          child: TextField(
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
              labelText:
                  (_appLocalizations.localization?.profileNameInput ?? ""),
            ),
          ),
        ),
      );

  Widget _widgetOfImage() => GestureDetector(
        onTap: _onPressedProfile,
        child: Stack(
          children: [
            Container(
              width: 150,
              height: 150,
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.colorGray,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(120),
              ),
              child: SvgPicture.asset(
                "assets/images/icon_profile.svg",
                color: AppColors.colorGray,
                width: 150,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.colorPrimary,
                  borderRadius: BorderRadius.circular(120),
                ),
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  "assets/images/icon_camera.svg",
                  color: AppColors.colorWhite,
                  width: 50,
                ),
              ),
            )
          ],
        ),
      );

  void _onPressedProfile() {
    print("a");
  }

  void _onPressedButtonContinue() {
    print("ac");
  }
}
