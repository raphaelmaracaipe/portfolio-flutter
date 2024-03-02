// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart'
    as _i9;
import 'package:portfolio_flutter/modules/uiauth/uiauth_pages.dart' as _i1;
import 'package:portfolio_flutter/modules/uicontacts/uicontact_pages.dart'
    as _i2;
import 'package:portfolio_flutter/modules/uicountry/uicountry_page.dart' as _i3;
import 'package:portfolio_flutter/modules/uiprofile/uiprofile_page.dart' as _i4;
import 'package:portfolio_flutter/modules/uisplash/uisplash_page.dart' as _i5;
import 'package:portfolio_flutter/modules/uivalidcode/uivalid_code_pages.dart'
    as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    UiAuthRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.UiAuthPage(),
      );
    },
    UiContactRoutes.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.UiContactPages(),
      );
    },
    UiCountryRoute.name: (routeData) {
      final args = routeData.argsAs<UiCountryRouteArgs>(
          orElse: () => const UiCountryRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.UiCountryPage(
          key: args.key,
          onRateCountry: args.onRateCountry,
        ),
      );
    },
    UiProfileRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.UiProfilePage(),
      );
    },
    UiSplashRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.UiSplashPage(),
      );
    },
    UiValidCodeRoutes.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.UiValidCodePages(),
      );
    },
  };
}

/// generated route for
/// [_i1.UiAuthPage]
class UiAuthRoute extends _i7.PageRouteInfo<void> {
  const UiAuthRoute({List<_i7.PageRouteInfo>? children})
      : super(
          UiAuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'UiAuthRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.UiContactPages]
class UiContactRoutes extends _i7.PageRouteInfo<void> {
  const UiContactRoutes({List<_i7.PageRouteInfo>? children})
      : super(
          UiContactRoutes.name,
          initialChildren: children,
        );

  static const String name = 'UiContactRoutes';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.UiCountryPage]
class UiCountryRoute extends _i7.PageRouteInfo<UiCountryRouteArgs> {
  UiCountryRoute({
    _i8.Key? key,
    void Function(_i9.CountryModel)? onRateCountry,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          UiCountryRoute.name,
          args: UiCountryRouteArgs(
            key: key,
            onRateCountry: onRateCountry,
          ),
          initialChildren: children,
        );

  static const String name = 'UiCountryRoute';

  static const _i7.PageInfo<UiCountryRouteArgs> page =
      _i7.PageInfo<UiCountryRouteArgs>(name);
}

class UiCountryRouteArgs {
  const UiCountryRouteArgs({
    this.key,
    this.onRateCountry,
  });

  final _i8.Key? key;

  final void Function(_i9.CountryModel)? onRateCountry;

  @override
  String toString() {
    return 'UiCountryRouteArgs{key: $key, onRateCountry: $onRateCountry}';
  }
}

/// generated route for
/// [_i4.UiProfilePage]
class UiProfileRoute extends _i7.PageRouteInfo<void> {
  const UiProfileRoute({List<_i7.PageRouteInfo>? children})
      : super(
          UiProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UiProfileRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.UiSplashPage]
class UiSplashRoute extends _i7.PageRouteInfo<void> {
  const UiSplashRoute({List<_i7.PageRouteInfo>? children})
      : super(
          UiSplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'UiSplashRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.UiValidCodePages]
class UiValidCodeRoutes extends _i7.PageRouteInfo<void> {
  const UiValidCodeRoutes({List<_i7.PageRouteInfo>? children})
      : super(
          UiValidCodeRoutes.name,
          initialChildren: children,
        );

  static const String name = 'UiValidCodeRoutes';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
