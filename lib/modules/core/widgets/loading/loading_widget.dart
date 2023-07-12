import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/config/app_fonts.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key("containerLoading"),
      color: Colors.white.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.discreteCircle(
              color: AppColors.colorPrimary,
              secondRingColor: AppColors.colorPrimary,
              thirdRingColor: AppColors.colorGray,
              size: 50,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                (AppLocalizations.of(context)?.loading ?? ""),
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: AppFonts.openSans,
                  fontStyle: FontStyle.normal,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
