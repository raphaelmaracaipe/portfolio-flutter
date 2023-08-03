import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portfolio_flutter/config/app_colors.dart';
import 'package:portfolio_flutter/config/app_route.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_event.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_state.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_status.dart';

class UiSplashPage extends StatelessWidget {
  final UiSplashBloc _uiSplashBloc = Modular.get();

  UiSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    _redirect();

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            _buildBloc(),
            Container(
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
          ],
        ),
      ),
    );
  }

  _buildBloc() {
    return BlocBuilder<UiSplashBloc, UiSplashBlocState>(
      bloc: _uiSplashBloc,
      builder: (context, state) {
        if (state.status == UiSplashBlocStatus.getRoute) {
          Modular.to.pushReplacementNamed(
            state.routeName.isNotEmpty ? state.routeName : AppRoute.uIAuth,
          );
        }
        return Container();
      },
    );
  }

  void _redirect() {
    Future.delayed(const Duration(seconds: 2), () {
      // _uiSplashBloc.add(GetRouteSaved());
    });
  }
}
