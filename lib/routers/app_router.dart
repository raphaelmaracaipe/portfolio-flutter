import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'app_router.gr.dart';

@Injectable(as: $AppRouter)
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: UiSplashRoute.page,
          initial: true,
          keepHistory: false,
        ),
        AutoRoute(
          page: UiAuthRoute.page,
        ),
        AutoRoute(
          page: UiValidCodeRoutes.page,
        ),
        AutoRoute(
          page: UiCountryRoute.page,
        ),
        AutoRoute(
          page: UiProfileRoute.page,
        )
      ];
}
