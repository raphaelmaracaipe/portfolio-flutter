import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/config/app_route.dart';
import 'package:portfolio_flutter/modules/core/localizations/app_localization.dart';
import 'package:portfolio_flutter/modules/core/widgets/bottomsheet/bottom_sheet.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_event.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_state.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_status.dart';

class UiSplashPage extends StatefulWidget {
  const UiSplashPage({super.key});

  @override
  State<UiSplashPage> createState() => _UiSplashPageState();
}

class _UiSplashPageState extends State<UiSplashPage> {
  final UiSplashBloc _uiSplashBloc = Modular.get();
  final Bottomsheet _bottomSheet = Modular.get();
  final AppLocalization _appLocalization = Modular.get();
  bool isShowFailRegister = false;

  @override
  void initState() {
    super.initState();
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
              color: AppColors.colorPrimary,
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
            Modular.to.pushReplacementNamed(
              state.routeName.isNotEmpty ? state.routeName : AppRoute.uIAuth,
            );
            return Container();
          case UiSplashBlocStatus.finishHandShake:
            _redirect();
            return Container();
          case UiSplashBlocStatus.errorHandShake:
            _showAlertError();
            return Container();
          default:
            return Container();
        }
      },
    );
  }

  void _redirect() {
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
