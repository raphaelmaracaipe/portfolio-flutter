import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/config/app_fonts.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';

class LoadingWidget extends StatefulWidget {
  final AppLocalization appLocalization;
  final ColorsU colorsU;

  const LoadingWidget({
    super.key,
    required this.appLocalization,
    required this.colorsU,
  });

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    widget.appLocalization.context = context;
    return Container(
      key: const Key("containerLoading"),
      color: Colors.white.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.discreteCircle(
              color: widget.colorsU.checkColorsWhichIsDarkMode(
                context: context,
                light: AppColors.colorPrimary,
                dark: AppColors.colorWhite,
              ),
              secondRingColor: widget.colorsU.checkColorsWhichIsDarkMode(
                context: context,
                light: AppColors.colorPrimary,
                dark: AppColors.colorWhite,
              ),
              thirdRingColor: AppColors.colorGray,
              size: 50,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                (widget.appLocalization.localization?.loading ?? ""),
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: AppFonts.openSans,
                  fontStyle: FontStyle.normal,
                  color: widget.colorsU.checkColorsWhichIsDarkMode(
                    context: context,
                    light: AppColors.colorGray,
                    dark: AppColors.colorBlack,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
