// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/utils/colors_u.dart';
import 'package:portfolio_flutter/modules/core/widgets/bottomsheet/bottom_sheet.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_event.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_state.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_status.dart';
import 'package:portfolio_flutter/routers/app_router.gr.dart';

@RoutePage()
class UiSplashPage extends StatefulWidget {
  const UiSplashPage({super.key});

  @override
  State<UiSplashPage> createState() => _UiSplashPageState();
}

class _UiSplashPageState extends State<UiSplashPage> {
  final ColorsU _color = GetIt.instance();
  final UiSplashBloc _uiSplashBloc = GetIt.instance();
  final Bottomsheet _bottomSheet = GetIt.instance();
  final AppLocalization _appLocalization = GetIt.instance();
  bool isShowFailRegister = false;

  @override
  void dispose() {
    super.dispose();
    _uiSplashBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    _appLocalization.context = context;
    _callServerToRegisterKey();

    return Scaffold(
      body: Stack(
        children: [
          _buildBloc(context),
          OverflowBox(
            child: Container(
              key: const Key('uisplash_container'),
              width: double.infinity,
              height: double.infinity,
              color: _color.checkColorsWhichIsDarkMode(
                context: context,
                light: AppColors.colorPrimary,
                dark: AppColors.colorBlack,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'img_app',
                    child: SvgPicture.asset(
                      "assets/images/icon_app.svg",
                      color: Colors.white,
                      width: 150,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: LoadingAnimationWidget.prograssiveDots(
                      size: 50,
                      color: Colors.white,
                      key: const Key('splash_screen_loading'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _callServerToRegisterKey() {
    _uiSplashBloc.add(SendCodeToServer());
  }

  _buildBloc(BuildContext ctx) {
    return BlocBuilder<UiSplashBloc, UiSplashBlocState>(
      bloc: _uiSplashBloc,
      builder: (context, state) {
        switch (state.status) {
          case UiSplashBlocStatus.getRoute:
            _checkWhichISendYou(state, context);
            return Container();
          case UiSplashBlocStatus.finishHandShake:
            _getRouteSaved();
            return Container(
              key: const Key('container_empty'),
            );
          case UiSplashBlocStatus.errorHandShake:
            _showAlertError();
            return Container(
              key: const Key('container_empty'),
            );
          default:
            return Container(
              key: const Key('container_empty'),
            );
        }
      },
    );
  }

  void _checkWhichISendYou(UiSplashBlocState state, BuildContext context) {
    if (state.routeName.isNotEmpty) {
      context.router.pushNamed("/${state.routeName}");
    } else {
      context.router.push(const UiAuthRoute());
    }
  }

  void _getRouteSaved() {
    Future.delayed(const Duration(seconds: 2), () {
      _uiSplashBloc.add(GetRouteSaved());
    });
  }

  void _showAlertError() {
    Future.delayed(Duration.zero, () {
      _bottomSheet.show(
        enableDrag: false,
        context: context,
        title: _appLocalization.localization?.generalAttention ?? "",
        text: _appLocalization.localization?.errorRegisterDeviceText ?? "",
        btnText: _appLocalization.localization?.generalOk ?? "",
        onBtnClick: () {
          exit(0);
        },
      );
    });
  }
}
